
var rules = {

  'wholesaler[email]':{
      required: true,
      email: true
  },

  'wholesaler[password]':{
      required: true,
      minlength: 5
  },
  'wholesaler[company_attributes][name]':{
    required: true
  },
  'wholesaler[company_attributes][address]':{
    required: true
  },
  'wholesaler[company_attributes][site]':{
    required: true
  },
  'wholesaler[company_attributes][inn]':{
    required: true
  },
  'wholesaler[company_attributes][kpp]':{
    required: true
  },
  'wholesaler[company_attributes][ogrn]':{
    required: true
  },
  'wholesaler[company_attributes][okpo]':{
    required: true
  },
  'wholesaler[company_attributes][bank_details]':{
    required: true
  }
}

var messages = {

  'wholesaler[email]':{
    required: "Для регистрации нужно ввести email",
    email: "Пожалуйста, введите корректный email"
  },

  'wholesaler[password]':{
    required: "Это поле обязательно для заполнения",
    minlength: "Пароль должен быть минимум 5 символа"
  },
  'wholesaler[company_attributes][name]':{
    required: "Это поле обязательно для заполнения"
  },
  'wholesaler[company_attributes][address]':{
    required: "Это поле обязательно для заполнения"
  },
  'wholesaler[company_attributes][site]':{
    required: "Это поле обязательно для заполнения"
  },
  'wholesaler[company_attributes][inn]':{
    required: "Это поле обязательно для заполнения"
  },
  'wholesaler[company_attributes][kpp]':{
    required: "Это поле обязательно для заполнения"
  },
  'wholesaler[company_attributes][ogrn]':{
    required: "Это поле обязательно для заполнения"
  },
  'wholesaler[company_attributes][okpo]':{
    required: "Это поле обязательно для заполнения"
  },
  'wholesaler[company_attributes][bank_details]':{
    required: "Это поле обязательно для заполнения"
  }
}

// $('[data-once=true]').live('ajax:before', function(request, e) {
//
// });

$("#new_wholesaler.register, .edit_wholesaler_profile").validate({
  rules: rules,
  messages: messages
})

$("#popupForgot .forgot").validate({
  rules: rules,
  messages: messages
})

$("#edit_wholesaler").validate({
  rules: {
    'wholesaler[password]':{
        required: true,
        minlength: 5
    },
    'wholesaler[password_confirmation]':{
        required: true,
        minlength: 5,
        equalTo : "#wholesaler_password"
    }
  },
  messages: {
    'wholesaler[password]':{
      required: "Это поле обязательно для заполнения",
      minlength: "Пароль должен быть минимум 5 символа"
    },
    'wholesaler[password_confirmation]':{
      required: "Это поле обязательно для заполнения",
      minlength: "Пароль должен быть минимум 5 символа",
      equalTo : "Пароль и подтверждениеразные"

    },
  }
})

$(".edit_wholesaler_update_password").validate({
  rules: {
    'wholesaler[current_password]':{
        required: true
    },
    'wholesaler[email]':{
        required: true,
        email: true
    }
  },
  messages: {
    'wholesaler[current_password]':{
      required: "Это поле обязательно для заполнения"
    },
    'wholesaler[email]':{
      required: "Для регистрации нужно ввести email",
      email: "Пожалуйста, введите корректный email"
    }
  }
})

window.jQuery(function ($) {
  if ($('.table-zippy').length > 0) {
      $('.table-zippy tr.heading').click(function () {
          var closestTable = $(this).closest('table');
          closestTable.siblings().removeClass('active');
          if (closestTable.hasClass('active')) {
              closestTable.removeClass('active');
          } else {
              closestTable.addClass('active');
          }
      });
  }

  // $('.btn.register').on( "click", function(){
  //   $("#new_wholesaler.register").validate({
  //       rules: rules,
  //       messages: messages,
  //       submitHandler: function(form) {
  //         //form.submit();
  //         $.ajax({
  //           url: form.action,
  //           type: form.method,
  //           data: $(form).serialize(),
  //           success: function(response) {
  //             console.log(response);
  //           }
  //         });
  //       }
  //   });
  // })

  // $('.btn.forgot').on( "click", function(){
  //   var form = $("#new_wholesaler.forgot");
  //   $.ajax({
  //     url: form.attr('action'),
  //     type: form.attr('method'),
  //     dataType: "json",
  //     data: $(form).serialize(),
  //     success: function(response) {
  //       console.log(response);
  //     }
  //   });
  // })

});
