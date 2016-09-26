function printDiv(divName) {
     var printContents = document.getElementById(divName).innerHTML;
     var originalContents = document.body.innerHTML;

     document.body.innerHTML = printContents;

     window.print();

     document.body.innerHTML = originalContents;
}

function imprSelec(nombre) {
    var ficha = document.getElementById(nombre);
    var ventimp = window.open(' ', 'popimpr');
    ventimp.document.write( ficha.innerHTML );
    ventimp.document.close();
    ventimp.print( );
    ventimp.close();
  }

function validateform() {

	this.click();	
}



window.addEventListener("awesomplete-selectcomplete", function(e){
$('.sale_comments').click();


}, false);



$(document).ready(function(){


 

	$(document).on("keypress", '.item_search_input', function(e){		
	   this.value = this.value.toUpperCase() 
     $('.category_search').click();
	  $('.item_search').click(); 
	});

   $(document).on("keypress", '.item_loco_input', function(){
	  $('.item_loco').click();
	});
     
   


                               
	$(document).on("change", '.item_category_search_input', function(){
	  $('.category_search').click();
	  $('.item_search').click();
	});


	$(document).on("change", "#sale_comments_start_date_1i", function(){		
    
		$('.sale_comments').click();
    alert("hola1");
	 });
	$(document).on("change", "#sale_comments_start_date_2i", function(){
   
		$('.sale_comments').click();
    alert("hola1");
	 });
	$(document).on("change", "#sale_comments_start_date_3i", function(){
    
		$('.sale_comments').click();
    alert("hola1");
	 });

    $( "#complete" ).click(function() {
	 });

//---------------------------------------------------------------


    $(document).on("click", "#pagamos", function(){
     // alert("cuenta pagada  ")

    // $('#makePayment').closeModal();
     $('#makePayment').modal('hide');
   
    

   });
	//--------------------------------------------------------------
      


     
	


	


	$(document).on("keypress", '.customer_search_input', function(){
	  $('.sale_comments').click();
	});

	$(document).on("change", "#sale_comments_comments", function(){
    alert("damos"); 
   $('.sale_comments').click();


	});

	$(document).on("change", "#sale_comments_employee", function(){
       
		$('.sale_comments').click();
	
	});

	$(document).on("change", "#sale_comments_customer_id", function(){
       
		$('.sale_comments').click();
	});

     $(document).keydown(function(tecla){ 
    
            if (tecla.keyCode == 112) { 
               
               PrintElem('#mydiv')
            }
             if(tecla.keyCode == 115) { 
              
              $("#customCustomers").modal()
            }
             if(tecla.keyCode == 118){ 
             	var  tex = new String($(document).find('.numeroItem').html());
                var num =	parseFloat(tex)
               

              if (num == 0 ){
                 alert('no puedo hacer pagos sin productos  error 404');
               }else {
               	  $("#makePayment").modal()
               }

                
            } 
             if(tecla.keyCode == 120){ 
                 $("#customCustomers").modal()
            }
             if(tecla.keyCode == 121){ 
                 $("#clientes").modal()
            }

            if (tecla.keyCode == 113){
              $(location).attr('href','/sales/new');
            }
        });  



      $('#customCustomers').on('shown.bs.modal', function () {
        $('#mama').focus();
        document.getElementById("mama").value = "";
        $('.item_search').click();
   var i = 1;
       $('#customCustomers').keydown(function(tecla){ 
           
            if (tecla.keyCode == 40) { 
            	if (i < 0){
            		i=1
            		
            	}
        
                var txtBox=document.getElementById(""+i+"add" );
                if (txtBox == null){
                	
                  alert("null 404 ")
                }
                else {
                
                     $( "button#"+i+"add.menosbot" ).focus();
                   //  $( "button#"+i+"add.menosbot" ).scrollIntoView();
                      i++

                }

                    
            }

            if (tecla.keyCode == 38){
            	var txtBox=document.getElementById(""+i+"add" );
                if (txtBox == null){
                	
             alert("null 404 ")
                }
                else {
                        
                     $( "button#"+i+"add.menosbot" ).focus();
                     i--
                }


            }
            console.log('contador'+i);
          });  

         });



      

    
      $('#makePayment').on('shown.bs.modal', function () {
        $('#payments_amount').focus();
        $('.payments_amount').value = 0 ;
         });






      $(document).on("click", ".dropdown-toggle", function(){

      var id = this.id 
 

      if( id == 0 ){
        //$("#Descuento").modal()
      }else {
        
      }
    
	   });


      $( "#mama" ).focus(function() {
       i= 0
     });



   

    $(document).on("change", "#line_item_price", function(){
    $.ajax({
      type: "POST",
      url: '/sales/override_price', //sumbits it to the given url of the form
      data: {override_price: { price: $(this).val(), line_item_sku: $(this).parent().parent().find('.line_item_sku').val(), sale_id: $(document).find('.sale_id').html() }},
      dataType: "script",
      success: function() {
        console.log('price updated');
      }
    });
    alert("esta es una alerta ")
  });




$(document).on("change", "#sale_discount", function(){
		$.ajax({
      type: "POST",
      url: '/sales/sale_discount', //sumbits it to the given url of the form
      data: {sale_discount: { discount: $(this).val(), sale_id: $(document).find('.sale_id').html() }},
      dataType: "script",
      success: function() {
      	console.log('sale discounted');
      }
    });
  	// alert('price');
	});


	$(document).on("change", "#item_discount", function(){
		 $('#an-id').click();
	});


// Jquery form validations
	$(".form_custom_item").validate({
		rules: {
			"custom_item[name]": {required: true },
			"custom_item[price]": {required: true, number: true},
			"custom_item[stock_amount]": {required: true, number: true}
		}
	});

	$(".edit_sale").validate({
		rules: {
			"line_item[price]": {required: true, number: true }
		}
	});

	$("#new_item").validate({
		rules: {
			"item[sku]": {required: true },
			"item[name]": {required: true },
			"item[price]": {required: true, number: true },
			"item[stock_amount]": {required: true, number: true },
			"item[cost_price]": {required: true, number: true }
		}
	});

	$("#new_user").validate({
		rules: {
			"user[email]": {required: true, email: true },
			"user[username]": {required: true },
			"user[password]": {required: true }
		}
	});

	$("#new_customer").validate({
		rules: {
			"customer[first_name]": {required: true },
			"customer[last_name]": {required: true },
			"customer[email_address]": {email: true }
		}
	});

	$("#create_custom_customer").validate({
		rules: {
			"custom_customer[first_name]": {required: true },
			"custom_customer[last_name]": {required: true },
			"custom_customer[email_address]": {email: true }
		}
	});

});



function myFunction() {
  
  var doc = new jsPDF();
var specialElementHandlers = {
    '#editor': function (element, renderer) {
        return true;
    }
};
doc.fromHTML($('#render_me').get(0),10,10, {
    'width': 50,
    'elementHandlers': specialElementHandlers
});


     doc.save('TestHTMLDoc.pdf');
}





