function review(book_review){
    $("#review_book_id").attr('value', $(book_review).attr('data-book-id'));
    $("#review-box-title").text($(book_review).attr('data-book-title'));
    $("#selected_rating").val(0);

  };
$(document).on('click','.btnrating',
function okkk(e){
var previous_value = $("#selected_rating").val();
var selected_value = $(this).attr("data-attr");
console.log(previous_value);
console.log(selected_value);
$("#selected_rating").val(selected_value);

for (i = 1; i <= selected_value; ++i) {
$("#rating-star-"+i).toggleClass('btn-warning');
$("#rating-star-"+i).toggleClass('btn-default');
}

for (ix = 1; ix <= previous_value; ++ix) {
$("#rating-star-"+ix).toggleClass('btn-warning');
$("#rating-star-"+ix).toggleClass('btn-default');
}
});

