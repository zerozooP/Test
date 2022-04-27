<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<jsp:include page="/WEB-INF/header.jsp"></jsp:include>
		<title>글쓰기</title>
		<script>
			function to_list() {
				location.href="/bbs_list/1";
			}
			
			function add_ajax(){
				var title = $("#title").val();
				var content = $("#content").val();
				var name = $("#name").val();
				alert(title + content + name);
				if(title=="" || content==""){
					alert("빈 항목을 입력해주세요");
					return false;
				}
				var serForm = $("#addForm").serialize();
				alert(serForm);
				$.ajax({
					url:"/bbs_add",
					method:"post",
					cache:false,
					data:serForm,
					dataType:"json",
					success:function(res){
						alert(res.added ? "작성 성공":"작성 실패");
						location.href="/bbs_list/1";
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
					<h1 class="text-center">Board Form</h1>
		            <div class="container">
						<form id="addForm" onsubmit="return add_ajax();">
							<div class="mb-3">
								<label for="title">제목</label>
								<input type="text" class="form-control" name="title" id="title" placeholder="제목을 입력해 주세요">
							</div>
							<div class="mb-3">
								<label for="reg_id">작성자</label>
								<input type="text" class="form-control" name="name" id="name" value="${name} (${uid})" disabled>
							</div>
							<div class="mb-3">
								<label for="content">내용</label>
								<textarea class="form-control" rows="5" name="content" id="content" placeholder="내용을 입력해 주세요" ></textarea>
							</div>
							<div class="mb-3">
								<label for="tag">파일 첨부</label>
								<input type="file" class="form-control">
							</div>
							<div >
								<button type="submit" class="btn btn-sm btn-primary">작성</button>
								<button type="button" class="btn btn-sm btn-primary" onclick="to_list();">목록</button>
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