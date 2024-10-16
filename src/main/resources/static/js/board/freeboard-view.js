// 게시글 삭제
function deletePost() {
    if (confirm("정말로 삭제하시겠습니까?")) {
        var form = document.deletePostForm;
        form.method = "post";
        form.action = "/freeboard/deletePost.do";
        form.submit();
    }
}


// 댓글 작성 모달창
function openWriteModal(board_ref) {
    document.getElementById("comm_write_board_ref").value = board_ref;
}


// 댓글 작성 (Ajax)
function writeComment() {
    var board_ref = $('#comm_write_board_ref').val();
    var content = $('#comm_write_content').val();
	
    if (!content.trim()) {
        alert("내용을 입력하세요");
        return false;
    }

    $.ajax({
        url: "../freeboard/writeComment.do",
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


// 댓글 수정 (Ajax)
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
        url: "../freeboard/editComment.do",
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


// 댓글 삭제 (Ajax)
function deleteComment(comm_idx, writer_ref, board_ref) {
    if (confirm("댓글을 삭제하시겠습니까?")) {
        $.ajax({
            url: "/freeboard/deleteComment.do",
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