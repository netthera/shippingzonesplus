<!-- INCLUDE user_menu_header.tpl -->

<script type='text/javascript'>  
	function sortSelect(selElem) {
    var tmpAry = new Array();
    for (var i=0;i<selElem.options.length;i++) {
        tmpAry[i] = new Array();
        tmpAry[i][0] = selElem.options[i].text;
        tmpAry[i][1] = selElem.options[i].value;
    }
    tmpAry.sort();
    while (selElem.options.length > 0) {
        selElem.options[0] = null;
    }
    for (var i=0;i<tmpAry.length;i++) {
        var op = new Option(tmpAry[i][0], tmpAry[i][1]);
        selElem.options[i] = op;
    }
    return;
}
function selectAll(selectBox,selectAll) { 
    // have we been passed an ID 
    if (typeof selectBox == 'string') { 
        selectBox = document.getElementById(selectBox);
    } 
    // is the select box a multiple select box? 
    if (selectBox.type == 'select-multiple') { 
        for (var i = 0; i < selectBox.options.length; i++) { 
             selectBox.options[i].selected = selectAll; 
        } 
    }
}
function selectZones(){
  selectAll('zone1',true);
  selectAll('zone2',true);
  selectAll('zone4',true);
}
  $().ready(function() {  
   $('#add1').click(function() {  
    $('#zone3 option:selected').remove().appendTo('#zone1');
    sortSelect(document.getElementById('zone1'));  
   });  
   $('#remove1').click(function() {  
    $('#zone1 option:selected').remove().appendTo('#zone3'); 
    sortSelect(document.getElementById('zone3')); 
    return ; 
   });   
   $('#add2').click(function() {  
    $('#zone3 option:selected').remove().appendTo('#zone2'); 
    sortSelect(document.getElementById('zone2'));
    return true; 
   });  
   $('#remove2').click(function() {  
    $('#zone2 option:selected').remove().appendTo('#zone3'); 
     sortSelect(document.getElementById('zone3'));
     return ;
   });  
   $('#add4').click(function() {  
    $('#zone3 option:selected').remove().appendTo('#zone4');
     sortSelect(document.getElementById('zone4'));
    return ;  
   });  
   $('#remove4').click(function() {  
   // return !$('#zone4 option:selected').remove().appendTo('#zone3'); 
  $('#zone4 option:selected').remove().appendTo('#zone3'); 
     sortSelect(document.getElementById('zone3'));
     return; 
   }); 

  });  
 </script> 
 
 <style type="text/css">  
  .selector a {  
   display: block;  
   border: 1px solid #aaa;  
   text-decoration: none;  
   background-color: #fafafa;  
   color: #123456;  
   margin: 2px;  
   
  }  
  .selector {  
   float:left;  
   text-align: center;  
   margin: 10px;  
   position: relative;
   width: 160px;  
   height: 260px;
   border:solid grey 0px;
   
  }  
  .selector   select {  
   width: 160px;  
   height:165px;  
  }  
 </style> 
 
 
 
 
 
 
 
<div style="height:280px;width:740px; margin:auto">
<form method=post>
<div class=selector> 
{L_ZONES_101}
  <select multiple name="zone1[]" id="zone1">
  <!-- BEGIN zone1 -->
		<option value="{zone1.COUNTRY}">{zone1.COUNTRY}</option>
	<!-- END zone1 -->	
</select>  
  <a href="#" id="remove1">remove &gt;&gt;</a>  
 </div> 
 <div class=selector> 
{L_ZONES_102} 
  <select multiple name="zone2[]" id="zone2">
  <!-- BEGIN zone2 -->
		<option value="{zone2.COUNTRY}">{zone2.COUNTRY}</option>
	<!-- END zone2 -->	
</select>  
  <a href="#" id="remove2">remove &gt;&gt;</a>  
 </div>  
 
<div class=selector>{L_ZONES_103} 
<select id="zone3" multiple="multiple">

  <!-- BEGIN zone3 -->
		<option value="{zone3.COUNTRY}">{zone3.COUNTRY}</option>
	<!-- END zone3 -->	

</select>
<a href="#" id="add1">{L_ZONES_121}</a> <a href="#" id="add2">{L_ZONES_122}</a> <a href="#" id="add4">{L_ZONES_131}</a>  
 </div>  
 <div class=selector> 
{L_ZONES_110} 
  <select multiple name="zone4[]" id="zone4">
  <!-- BEGIN zone4 -->
		<option value="{zone4.COUNTRY}">{zone4.COUNTRY}</option>
	<!-- END zone4 -->	
</select>  
  <a href="#" id="remove4">{L_ZONES_120}</a>  
 </div>
 <div style="clear:both;text-align: center;margin:bottom:40px;">
 <input type=submit  value="{L_ZONES_140}" onclick="selectZones()">
 <input type="hidden" name="csrftoken" value="{_CSRFTOKEN}">
 <input type=hidden name=action value="save">
  </div>
 </form>
 </div><br><br>
