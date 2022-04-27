<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<jsp:include page="/WEB-INF/header.jsp"></jsp:include>
		<title>글쓰기</title>
		<script>
			function edit_ajax() {
				var title = $('#title').val();
				var content = $('#content').val();
				if(title=="" || content==""){
					alert("빈칸을 채워주세요");
					return false;
				}
				if(!confirm("정말로 수정하시겠습니까?")){
					return false;
				}
				var serForm = $("#editForm").serialize();
				$.ajax({
					url:"/bbs_edit",
					method:"post",
					cache:false,
					dataType:"json",
					data:serForm,
					success:function(res){
						alert(res.edited ? "수정 성공":"수정 실패");
						location.href="/bbs_detail/${edit.num}";
					},
					error:function(xhr, status, err){
						alert(err);
					}
				});
				return false;
			}
		</script>
	</head>
	<body>
		<jsp:include page="/WEB-INF/topnav.jsp"></jsp:include>
		<div id="layoutSidenav">
		
			<jsp:include page="/WEB-INF/sidenav.jsp"></jsp:include>
			<div id="layoutSidenav_content">
				<main>
					<br>
					<h1 class="text-center">Edit Form</h1>
		            <div class="container">
						<form id="editForm" onsubmit="return edit_ajax();">
							<input type="hidden" name="num" value=${edit.num}>
							<div class="mb-3">
								<label for="title">제목</label>
								<input type="text" class="form-control" name="title" id="title" value=${edit.title}>
							</div>
							<div class="mb-3">
								<label for="reg_id">작성자</label>
								<input type="text" class="form-control" name="name" id="name" value=${edit.name} disabled>
							</div>
							<div class="mb-3">
								<label for="content">내용</label>
								<textarea class="form-control" rows="5" name="content" id="content">${edit.content}</textarea>
							</div>
							<div class="mb-3">
								<label for="tag">파일 첨부</label>
								<input type="file" class="form-control">
							</div>
							<div >
								<button type="submit" class="btn btn-sm btn-primary">수정</button>
								<a href="/bbs_detail/${edit.num}" class="btn btn-sm btn-primary" >취소</a>
							</div>
						</form>
					</div>
				</main>
				<jsp:include page="/WEB-INF/footer.jsp"></jsp:include>
			</div>
		</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
	</body>
</html>