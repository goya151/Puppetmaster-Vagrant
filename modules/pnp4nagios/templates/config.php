<?php
$conf['use_url_rewriting'] = 1;
$conf['rrdtool'] = "/usr/bin/rrdtool";
$conf['graph_width'] = "500";
$conf['graph_height'] = "100";
$conf['zgraph_width'] = "500";
$conf['zgraph_height'] = "100";
$conf['right_zoom_offset'] = 30;
$conf['pdf_width']        = "675";
$conf['pdf_height']       = "100";
$conf['pdf_page_size']    = "A4";   # A4 or Letter
$conf['pdf_margin_top']   = "30";
$conf['pdf_margin_left']  = "17.5";
$conf['pdf_margin_right'] = "10";
$conf['graph_opt'] = ""; 
$conf['pdf_graph_opt'] = ""; 
$conf['rrdbase'] = "/var/lib/pnp4nagios/perfdata/";
$conf['page_dir'] = "/etc/pnp4nagios/pages/";
$conf['refresh'] = "90";
$conf['max_age'] = 60*60*6;   
$conf['temp'] = "/var/tmp";
$conf['nagios_base'] = "/cgi-bin/nagios3";
$conf['multisite_base_url'] = "/check_mk";
$conf['multisite_site'] = "";
$conf['auth_enabled'] = FALSE;
$conf['livestatus_socket'] = "unix:/usr/local/nagios/var/rw/live";
$conf['allowed_for_all_services'] = "";
$conf['allowed_for_all_hosts'] = "";
$conf['allowed_for_service_links'] = "EVERYONE";
$conf['allowed_for_host_search'] = "EVERYONE";
$conf['allowed_for_host_overview'] = "EVERYONE";
$conf['allowed_for_pages'] = "EVERYONE";
$conf['overview-range'] = 1 ;
$conf['popup-width'] = "300px";
$conf['ui-theme'] = 'smoothness';
$conf['lang'] = "en_US";
$conf['date_fmt'] = "d.m.y G:i";
$conf['enable_recursive_template_search'] = 1;
$conf['show_xml_icon'] = 1;
$conf['use_fpdf'] = 1;	
$conf['background_pdf'] = '/etc/pnp4nagios/background.pdf' ;
$conf['use_calendar'] = 1;
#$views[] = array('title' => 'One Hour',  'start' => (60*60) );
$views[] = array('title' => '4 Hours',   'start' => (60*60*4) );
$views[] = array('title' => '25 Hours',  'start' => (60*60*25) );
$views[] = array('title' => 'One Week',  'start' => (60*60*25*7) );
$views[] = array('title' => 'One Month', 'start' => (60*60*24*32) );
$views[] = array('title' => 'One Year',  'start' => (60*60*24*380) );
# $conf['RRD_DAEMON_OPTS'] = 'unix:/tmp/rrdcached.sock';
$conf['RRD_DAEMON_OPTS'] = '';
#$conf['template_dirs'][] = '/usr/local/check_mk/pnp-templates';
$conf['template_dirs'][] = '/etc/pnp4nagios/templates';
$templates_d = glob("/etc/pnp4nagios/templates.d/*", GLOB_ONLYDIR);
if (is_array($templates_d) && (count($templates_d) > 0)) {
	foreach ($templates_d as $dirname) {
		$conf['template_dirs'][] = "$dirname";
	}
}
$conf['template_dirs'][] = '/usr/share/pnp4nagios/html/templates.dist';

$conf['special_template_dir'] = '/etc/pnp4nagios/templates.special';

$conf['mobile_devices'] = 'iPhone|iPod|iPad|android';
?>
