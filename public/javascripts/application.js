// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
	
	// Saves the newly created note
	var timerId = null;
	$('#body').keyup(function(){
		if (timerId) {
			clearTimeout(timerId);
		}
		var noteVal = $(this).val();
		timerId = setTimeout(function() {
			if(noteVal != "") {
				$("#new_note").trigger("submit");			
			}
		}, 1000);
	});
	
	// Get more notes as scroll
	function get_more_notes_as_scroll(counter) {

	  var page = counter,
	      loading = false;

	  function nearBottomOfPage() {
	    return $(window).scrollTop() > $(document).height() - $(window).height() - 200;
	  }

	  $(window).scroll(function(){
	    if (loading) {
	      return;
	    }

	    if(nearBottomOfPage()) {
	      loading=true;
	      page++;
	      $.ajax({
	        url: '/notes?page=' + page,
	        type: 'get',
	        dataType: 'script',
	        success: function() {
	          $(window).sausage('draw');
	          loading=false;
	        }
	      });
	    }
	  });

	  $(window).sausage();
	}
	
	// Load notes into application
	function load_pages(counter) {
		$.ajax({
			url: '/notes?page=' + counter,
			type: 'get',
			dataType: 'script',
			success: function(data) {
				$(window).sausage('draw');
				loading=false;
				if (($("body").height() < $(window).height()) && ($.trim(data).length > 0)) {
					load_pages(counter+1);
				} else {
					get_more_notes_as_scroll(counter);
				}
			}
		});
		return counter;
	}
	load_pages(1);
	
	// Focus on the first textarea
	$("textarea:first").focus();
	
	// Removes buttons
	$(".submit_note_edit").remove();
	
});