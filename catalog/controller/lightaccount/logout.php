<?php
// *	@source		See SOURCE.txt for source and other copyright.
// *	@license	GNU General Public License version 3; see LICENSE.txt

class ControllerLightaccountLogout extends Controller {
	public function index() {
		
		$json = array();
		
		if ($this->customer->isLogged()) {
			
			$this->Lightlogout();
		}		

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
		
	}
	
	public function Lightlogout() {
		unset($this->session->data['customer_id']);
	}
}
