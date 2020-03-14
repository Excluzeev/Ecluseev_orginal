function openNav() {
	document.getElementById("mySidenav").style.width = "250px";
}

function closeNav() {
	document.getElementById("mySidenav").style.width = "0";
}

function openVideo() {
	document.getElementById("mySideVideo").style.width = "100%";
}

function closeVideo() {
	document.getElementById("mySideVideo").style.width = "0";
}



$(document).ready(function() {
	$('.owl-carousel').owlCarousel({
		loop: true,
		margin: 10,
		responsiveClass: true,
		// stagePadding: 50,
		nav: true,
		navText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
		responsive: {
			0: {
				items: 1,
				nav: true,
				margin:20
			},
			600: {
				items: 2,
				nav: true,
				margin:20
			},
			1000: {
				items: 3,
				nav: true,
				margin:20
			},
			1400: {
				items: 4,
				nav: true,
				loop: false,
				margin: 40
			},
			1923: {
				items: 6,
				nav: true,
				loop: false,
				margin: 40
			}
		}
	});
});

window.onscroll = function() {myFunction()};

var header = document.getElementById("nav");
var sticky = header.offsetTop;

function myFunction() {
	if (window.pageYOffset > sticky) {
		header.classList.add("sticky");
	} else {
		header.classList.remove("sticky");
	}
}

$(document).ready(function(){
	$('#months_input').prop('disabled', true);
	$('#plus-btn').click(function(){
		$('#months_input').val(parseInt($('#months_input').val()) + 1 );
	});
	$('#minus-btn').click(function(){
		$('#months_input').val(parseInt($('#months_input').val()) - 1);
		if ($('#months_input').val() == 0) {
			$('#months_input').val(1);
		}

	});
});

/*---Read More----*/
$(document).ready(function () {
    $('.nav-toggle').click(function () {
        var collapse_content_selector = $(this).attr('href');
        var toggle_switch = $(this);
        $(collapse_content_selector).toggle(function () {
            if ($(this).css('display') == 'none') {
                toggle_switch.html('Read More');
            } else {
                toggle_switch.html('Read Less');
            }
        });
    });

});

