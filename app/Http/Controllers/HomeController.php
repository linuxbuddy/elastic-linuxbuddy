<?php

namespace App\Http\Controllers;

use Laravel\Lumen\Routing\Controller as BaseController;
use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken as BaseVerifier;
use Illuminate\Http\Request;
use Elasticsearch;

class HomeController extends BaseController
{
	/**
	 * @var ElasticsearchNamespace
	 */
	protected $_elasticSearchClient;

	/**
	 * Search data
	 * @var array
	 */
	protected $_searchHandle;

	/**
	 * Render the home view
	 * @return Home view
	 */
    public function index(Request $request) {

		if ($request->isMethod('post')) {
			$this->searchHandle = $this->search();
		}

    	return view('home.index', ['results'=> '$this->searchData']);
    }
}
