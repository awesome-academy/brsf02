function edit_comment(button){
    $("#modal_comment_content").val($(button).attr('data-content'));
    $("#modal-comment-form").attr('action', ('/comments/' + $(button).attr('data-comment-id')));
    $("#delete-comment-form").attr('action', ('/comments/' + $(button).attr('data-comment-id')));
  };
