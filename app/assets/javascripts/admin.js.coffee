ready = ->
  $('#users').dataTable()
  $('#associates').dataTable()
  $ ->
  $("#tab-content").hide()
  $('#role_id').change ->
    if $('#role_id option:selected').text() != 'associate'
      $('#associate_type').attr('disabled','true')
      $('#associate_type select').attr('disabled','true')
      $('#associate_type select').val('none')
      $('#associate_type').hide()
    else 
      $('#associate_type').removeAttr('disabled')
      $('#associate_type select').removeAttr('disabled') 
      $('#associate_type').show()
  $(".view-updates").click ->
    console.log "fired"
    $("#tab-content").show()
    $(".mentee-update-table").hide()
    return

  $("#back").click ->
    $("#tab-content").hide()
    $(".mentee-update-table").show()
    return

  return

$(document).ready(ready)
$(document).on('page:load', ready)  