
$(document).ready(function(){
	$("#deadline").datepicker({
		autoclose: true,
		todayHighlight: true,
    format: 'yyyy/mm/dd',
    keyboardNavigation: true,
    startDate: new Date()
	});
	$("#task").click(function(){
	  var val;
	  val = void 0;
	  val = $("ul.nav li.active a").attr("href");
	  $("#title , #details ").val("");
	  $("#deadline").attr('placeholder','');
	  $("#details-error , #title-error , #deadline-error").text("");
	  $("#mentee_id").val(val.substr(1, 5));
	  console.log(val);
	  $("#title").blur(function() {
	  if ((!this.value) || (this.value === " ")) {
	   $("#title-error").text("Title cannot be left blank");
	   $("#task_submit").attr("disabled", "disabled");
	  } 
	  else {
	    $("#title-error").text("");
	   }
    });
    $("#details").blur(function() {
      if ((!this.value) || (this.value === " ")) {
        $("#details-error").text("Details cannot be left blank");
        $("#task_submit").attr("disabled", "disabled");
      } else {
        $("#details-error").text("");
        $("#task_submit").removeAttr("disabled");
      }
    });
    if (!($("#title").value) || !($("#details").value) || !($('#deadline').value)) {
      $("#task_submit").attr("disabled", "disabled");
    } else {
      $("#task_submit").removeAttr("disabled");
    }
  });
    $("#task_submit").mouseup(function() {
      $(this).attr("data-dismiss", "modal");
      $("#task_form").submit();
      $("#task-error-div").css("display", "block");
      $("#task-error-div").addClass("alert alert-success");
      $("#task-error-div").text("Task Assigned");
    });	
});
