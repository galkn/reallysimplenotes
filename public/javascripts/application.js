// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
	
	// Focus on the first textarea
	$("textarea:first").focus();
	
	// Removes buttons
	$(".submit_note_edit").remove();
	
	// Saves the notes after you edit them
	var timerId = null;
	$('.note_editing_area').keyup(function(){
		if (timerId) {
			clearTimeout(timerId);
		}
		var noteVal = $(this).val();
		var noteId = $(this).attr("id").replace("body", "");
		var noteId = $(this).attr("id");
		timerId = setTimeout(function() {
			if(noteVal != "") {
				$("#" + noteId).trigger("submit");			
			}
		}, 1000);
	});
	
	(function() {
	  var page = 1,
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
	}());
	
});