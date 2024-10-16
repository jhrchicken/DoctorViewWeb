// 게시글 삭제 (Ajax)
/*
function deletePost(board_idx) {
    if (confirm("정말로 삭제하시겠습니까?")) {
        $.ajax({
            url: "/freeboard/deletePost.do",
            type: "POST",
            data: { board_idx: board_idx },
            success: function(response) {
                if (response.result === "success") {
                    alert("게시글이 삭제되었습니다");
                    window.location.href = "/freeboard.do";
                } else {
                    alert("게시글 삭제에 실패했습니다.");
                }
            },
            error: function() {
                alert("오류가 발생했습니다.");
            }
        });
    }
}
*/

// 게시글 삭제
function deletePost() {
    if (confirm("정말로 삭제하시겠습니까?")) {
        var form = document.deletePostForm;
        form.method = "post";
        form.action = "/freeboard/deletePost.do";
        form.submit();
    }
}


// 댓글 삭제
/*
function deleteComment(board_ref, comm_idx, writer_ref) {
    if (confirm("댓글을 삭제하시겠습니까?")) {
        var form = document.deleteCommentForm;
        // hidden 필드에 값을 동적으로 설정
        form.board_ref.value = board_ref;
        form.comm_idx.value = comm_idx;
        form.writer_ref.value = writer_ref;
        form.method = "post";
        form.action = "/freeboard/deleteComment.do";
        form.submit();
    }
}
*/

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





// 댓글 작성 모달 열기
function openWriteModal(board_ref) {
    document.getElementById("board_ref").value = board_ref;
}

// 댓글 수정 모달 열기
function openEditModal(board_ref, comm_idx, content, writer_ref) {
    document.getElementById("board1_ref").value = board_ref;
    document.getElementById("content").value = content;
    document.getElementById("comm_idx").value = comm_idx;
    document.getElementById("writer_ref").value = writer_ref;
}

// 댓글 작성/수정 폼 유효성 검사
function validateCommentForm(form) {
    if (form.content.value.trim() === "") {
        alert("내용을 입력하세요.");
        form.content.focus();
        return false;
    }
    return true;
}
