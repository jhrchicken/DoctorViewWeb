// 게시글 삭제
function deletePost() {
    if (confirm("정말로 삭제하시겠습니까?")) {
        var form = document.deletePostForm;
        form.method = "post";
        form.action = "/qnaboard/deletePost.do";
        form.submit();
    }
}


// 댓글 작성 모달창
function openWriteModal(board_ref) {
    document.getElementById("comm_write_board_ref").value = board_ref;
}


// 댓글 작성 (AJAX)
function writeComment() {
    var board_ref = $('#comm_write_board_ref').val();
    var content = $('#comm_write_content').val();
	
    if (!content.trim()) {
        alert("내용을 입력하세요");
        return false;
    }

    $.ajax({
        url: "../qnaboard/writeComment.do",
        type: "POST",
        data: {
            board_ref: board_ref,
            content: content
        },
        success: function(response) {
            if (response.result === "success") {
                var newComment = `
                    <tr id="comment-${response.comment.comm_idx}" align="center">
                        <td class="writer">${response.comment.nickname}</td>
                        <td class="comm_content" align="left">${response.comment.content}</td>
                        <td class="postdate">${response.comment.postdate}</td>
                        <td class="comm_btn">
                            <button type="button" data-bs-toggle="modal" data-bs-target="#editCommentModal"
                                    onclick="openEditModal(${response.comment.board_ref}, ${response.comment.comm_idx}, '${response.comment.content}', '${response.comment.writer_ref}')">
                                수정
                            </button>
                            <button type="button" onclick="deleteComment(${response.comment.comm_idx}, '${response.comment.writer_ref}', ${response.comment.board_ref});">
                                삭제
                            </button>
                        </td>
                    </tr>`;
                $('.comment tbody').append(newComment);
                $('#writeCommentModal').modal('hide');
                $('#comm_write_content').val('');
				
				// 기존 댓글이 없는 경우 새로고침
				if (response.comment.commentcount === 0) {
					location.reload();
				}
				
            } else {
                alert("댓글 작성에 실패했습니다.");
            }
        },
        error: function() {
            alert("댓글 작성에 실패했습니다.");
        }
    });
	
    return false;
}


// 댓글 수정 모달창
function openEditModal(comm_idx, content, writer_ref, board_ref) {
    document.getElementById("comm_edit_comm_idx").value = comm_idx;
    document.getElementById("comm_edit_content").value = content;
    document.getElementById("comm_edit_writer_ref").value = writer_ref;
    document.getElementById("comm_edit_board_ref").value = board_ref;
}


// 댓글 수정 (AJAX)
function editComment() {
    var comm_idx = $('#comm_edit_comm_idx').val();
    var content = $('#comm_edit_content').val();
    var writer_ref = $('#comm_edit_writer_ref').val();
    var board_ref = $('#comm_edit_board_ref').val();
	
    if (!content.trim()) {
        alert("내용을 입력하세요");
        return false;
    }

    $.ajax({
        url: "../qnaboard/editComment.do",
        type: "POST",
        data: {
			comm_idx: comm_idx,
            content: content,
			writer_ref: writer_ref,
            board_ref: board_ref,
        },
        success: function(response) {
            if (response.result === "success") {
				$(`#comment-${comm_idx}`).find('.comm_content').text(content);
                $('#editCommentModal').modal('hide');
                $('#comm_edit_content').val('');
            } else {
                alert("댓글 수정에 실패했습니다.");
            }
        },
        error: function() {
            alert("댓글 수정에 실패했습니다.");
        }
    });
	
    return false;
}


// 댓글 삭제 (AJAX)
function deleteComment(comm_idx, writer_ref, board_ref) {
    if (confirm("댓글을 삭제하시겠습니까?")) {
        $.ajax({
            url: "/qnaboard/deleteComment.do",
            type: "POST",
            data: {
                comm_idx: comm_idx,
                board_ref: board_ref,
                writer_ref: writer_ref
            },
            success: function(response) {
                if (response.result === "success") {
                    alert("댓글이 삭제되었습니다");
                    $('#comment-' + comm_idx).remove();
					
					// 삭제 후 댓글이 없는 경우 새로고침
					if (response.commentcount === "0") {
						location.reload();
					}
					
                } else {
                    alert("댓글 삭제에 실패했습니다"); 
                }
            },
            error: function() {
                alert("댓글 삭제에 실패했습니다");
            }
        });
    }
}


// 좋아요 기능 (AJAX)
function clickLike(boardIdx) {
    $.ajax({
        url: '/qnaboard/clickLike.do',
        type: 'POST',
        data: { board_idx: boardIdx },
        success: function(response) {
			if (response.result === "success") {
                $('#likeCount').text(response.likeCount);
				$('#reportCount').text(response.reportCount);
                if (response.likeCheck === 0) {
                    $('#likeButton').addClass('push');
					if (response.reportCheck !== 0) {
						$('#reportButton').removeClass('push');
					}
                } else {
                    $('#likeButton').removeClass('push');
                }
            } else {
                alert("오류가 발생했습니다");
            }
        },
        error: function() {
        	alert("오류가 발생했습니다");
        }
    });
}

// 신고 기능 (AJAX)
function clickReport(boardIdx) {
    $.ajax({
        url: '/qnaboard/clickReport.do',
        type: 'POST',
        data: { board_idx: boardIdx },
        success: function(response) {
			if (response.result === "success") {
                $('#reportCount').text(response.reportCount);
				$('#likeCount').text(response.likeCount);
                if (response.reportCheck === 0) {
                    $('#reportButton').addClass('push');
					if (response.likeCheck !== 0) {
						$('#likeButton').removeClass('push');
					}
                } else {
                    $('#reportButton').removeClass('push');
                }
            } else {
                alert("오류가 발생했습니다");
            }
        },
        error: function() {
            alert("오류가 발생했습니다");
        }
    });
}







/**
 * 게시글 내용을 입력했는지 검증하는 함수
 * 
 * @param {Form} form - 검증할 HTML폼 객체
 * @returns {boolean} - 검증 결과  
 */
function validateWriteForm(form) {
	if (form.title.value == '') {
		alert("제목을 입력하세요.");
		form.title.focus();
		return false;
	}
	if (form.content.value == '') {
		alert("내용을 입력하세요.");
		form.content.focus();
		return false;
	}
	return true;
}







