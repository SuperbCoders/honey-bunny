//= require jquery_nested_form
//= require chosen-jquery
//= require ./chosen_setup


$(function(){
	$('.new-nested-block').on( "click", function(){
    var parent = $(this).parents('.nested-blocks');
    var forms = parent.find('.nested-block');
    var forms_count = forms.length;
    console.log(forms_count);
    if (forms_count > 0){
      var last = forms.get(forms_count - 1 );
      $(last).find('form.nested-block-form').submit();
    }
  });
});
