<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
		<jsp:include page="/WEB-INF/header.jsp"></jsp:include>

        <title>Login - SB Admin</title>

	    <script>
		if ('${msg}') {
			alert('${msg}');
		}
		</script>
	    <script>
			function login() {
				var serData = $('#loginform').serialize();
				$.ajax({
					url : '/login',
					method : 'post',
					cache : false,
					data : serData,
					dataType : 'json',
					success : function(res) {
						console.log("res"+res)
						alert(res.ok ? '로그인 성공' : '로그인 실패');
						location.href = '/bbs_list/1';
					},
					error : function(xhr, status, err) {
						alert('에러:' + err);
					}
				});
				return false;
			}
		</script>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-5">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">Login</h3></div>
                                    <div class="card-body">
                                        <form id="loginform" onsubmit="return login();">
                                            <div class="form-floating mb-3">
                                                <input class="form-control" name="uid" id="uid" type="text" placeholder="ID" />
                                                <label for="inputEmail">ID</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" name="pwd" id="pwd" type="password" placeholder="Password" />
                                                <label for="inputPassword">Password</label>
                                            </div>
                                            <div class="form-check mb-3">
                                                <input class="form-check-input" id="inputRememberPassword" type="checkbox" value="" />
                                                <label class="form-check-label" for="inputRememberPassword">Remember Password</label>
                                            </div>
                                            <div class="d-flex align-items-center justify-content-between mt-4 mb-0">
                                                <a class="small" href="password">Forgot Password?</a>
                                                <button class="btn btn-primary" type="submit">Login</button>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a href="/adduser">Need an account? Sign up!</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <div id="layoutAuthentication_footer">
                <jsp:include page="/WEB-INF/footer.jsp"></jsp:include>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/js/scripts.js"></script>
    </body>
</html>