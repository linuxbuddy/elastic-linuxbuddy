<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken as BaseVerifier;
use Illuminate\Http\Request;
use Elasticsearch\Client as Elasticsearch;

class HomeController extends BaseController
{
	/**
	 * @var ElasticsearchNamespace
	 */
	protected $_elasticSearchClient;

	/**
	 * Initialise our Elasticsearch Client
	 */
	public function __construct() 
	{
		if (!$this->_elasticSearchClient) {
			$this->_elasticSearchClient = new Elasticsearch();
		}
	}

	/**
	 * Render the home view
	 * @return Home view
	 */
    public function index(Request $request) 
    {
    	$results = null;

    	if ($request->isMethod('post') 
    		&& $request->input('search') != ''
    	) {
    		//TODO: Security issue! 
    		//Need to add templating system for escaping
    		//before hitting Elasticsearch.
    		$results = $this->_searchData($request->input('search'));
    	}

	    return view('home.index', array(
	    		'results' 	=> $results,
	    		'search' 	=> $request->input('search')
	    	)
	    );
	}
	
	/**
	 * Insert some test data
	 */
	private function insertTestData() 
	{
		$params = array();

		$params['index'] = 'linux_buddy';
		$params['type']  = 'commands';
		$params['body']  = array(
				'description' => 'List files and folders within a directory',
				'os' => '*Nix Distributed Systems',
				'command' => 'ls;ls -la;ls -l'
			);
		$params['id'] = 1;

		$this->_elasticSearchClient->index($params);
	}

	/**
	 * Peform search
	 * @return array|bool Results
	 */
	protected function _searchData($search = null)
	{
		$params = array();
		
		$params['index'] = 'linux_buddy';
		$params['type']  = 'commands';
		$params['body']['query']['bool']['should'] = array(
				array('match' => array('command' => $search)),
				array('match' => array('description' => $search)),
				array('match' => array('os' => $search)),
			);

		$results = $this->_elasticSearchClient->search($params);

		if (!empty($results['hits']['hits']) 
			&& $results = $results['hits']['hits']) {
    		
    		$formatted_result_arr = array();
			
			for ($i=0; $i < count($results); $i++) {
				
				$r = $results[$i]['_source'];

				$formatted_result_arr[$i]['description'] = $r['description'];
				$formatted_result_arr[$i]['command'] = $r['command'];
				$formatted_result_arr[$i]['os'] = $r['os'];

			}

			return $formatted_result_arr;
		} else {
			return false;
		}
	}
}
