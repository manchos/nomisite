$(document).ready(function(){
        $("#telephone").mask("+7 (999) 999-99-99");
        $("#birthdate").mask("99.99.9999");
        $.datepicker.setDefaults(
            $.extend($.datepicker.regional["ru"])
        );
	$.datepicker.regional['ru'] = {
		closeText: 'Закрыть',
		prevText: '',
		nextText: '',
		currentText: 'Сегодня',
		monthNames: ['Январь','Февраль','Март','Апрель','Май','Июнь',
		'Июль','Август','Сентябрь','Октябрь','Ноябрь','Декабрь'],
		monthNamesShort: ['Янв','Фев','Мар','Апр','Май','Июн',
		'Июл','Авг','Сен','Окт','Ноя','Дек'],
		dayNames: ['воскресенье','понедельник','вторник','среда','четверг','пятница','суббота'],
		dayNamesShort: ['вск','пнд','втр','срд','чтв','птн','сбт'],
		dayNamesMin: ['Вс','Пн','Вт','Ср','Чт','Пт','Сб'],
		weekHeader: 'Нед',
		dateFormat: 'dd.mm.yy',
		firstDay: 1,
		isRTL: false,
                changeYear:true,
		showMonthAfterYear: false,
		yearSuffix: ''};
	$.datepicker.setDefaults($.datepicker.regional['ru']);
        $("#birthdate").datepicker({yearRange: "1960:2000"});
//'option', $.datepicker.regional["ru"]

       
       $("#SignupForm").validate({

       rules:{

            email:{
                required: true,
                email: true,
            },

            password:{
                required: true,
                minlength: 6,
                maxlength: 12,
            },
            confirm:{
                required: true,
                equalTo: "#password",
            },
            firstname:{
                required: true,
                minlength: 3,
                maxlength: 32,
            },
            lastname:{
                required: true,
                minlength: 2,
                maxlength: 32,
            },
            gender:{
                required: true,
            },
            address_1:{
                required: true,
                minlength: 3,
                maxlength: 128,
            },
            city:{
                required: true,
                minlength: 2,
                maxlength: 128,
            }
       },

       messages:{

            email:{
                required: "Это поле обязательно для заполнения",
                email: "пожалуйста введите правильный email-адрес",
            },

            password:{
                required: "Это поле обязательно для заполнения",
                minlength: "Пароль должен быть минимум 6 символа",
                maxlength: "Пароль должен быть максимум 12 символов",
            },
            confirm:{
                equalTo: "Проверьте правильность пароля",
            },
            firstname:{
                required: "Это поле обязательно для заполнения",
                minlength: "Должно быть минимум 3 символа",
                maxlength: "Должно быть максимум 32 символа",
            },
            lastname:{
                required: "Это поле обязательно для заполнения",
                minlength: "Должно быть минимум 2 символа",
                maxlength: "Должно быть максимум 32 символа",
            },
            gender:{
                required: "Вы должны указать пол",
            },
            address_1:{
                required: "Это поле обязательно для заполнения",
                minlength: "Должно быть минимум 3 символа",
                maxlength: "Должно быть максимум 128 символов",
            },
            city:{
                required: "Это поле обязательно для заполнения",
                minlength: "Должно быть минимум 2 символа",
                maxlength: "Должно быть максимум 128 символов",
            }
       }

    });
});
