<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<jsp:include page="/WEB-INF/header.jsp"></jsp:include>
		<title>게시글 상세 보기</title>
		<script>
			function edit(uid){
				location.href="/bbs_edit/${detail.num}";
			}
		
			function del(num, uid){
				if(!confirm("정말로 삭제하시겠습니까?")){
					return false;
				}
				$.ajax({
					url:"/bbs_delete/"+num,
					method:'post',
					cache:false,
					dataType:"json",
					success:function(res){
						alert(res.deleted ? "삭제 성공":"삭제 실패");
						location.href="/bbs_list/1";
					},
					error:function(xhr, status, err){
						alert(err);
					}
				});
			}
			
			function reply_ajax(){
				var cmt = $('#cmt').val();
				if(cmt == ""){
					alert("내용을 입력해 주세요");
					return false;
				}
				var serForm = $('#replyForm').serialize();
				$.ajax({
					url 		: "/reply_add",
					method 		: 'post',
					cache 		: false,
					dataType 	: "json",
					data		: serForm,
					success:function(res){
						alert(res.added ? "작성 완료":"작성 실패");
						location.href="/bbs_detail/${detail.num}";
					},
					error:function(xhr, status, err){
						alert(err);
					}
				});
				return false;
			}
			
			function reRep(rno, grps, ruid){
				var listHtml = '<form id="reReplyForm" onsubmit="return reReply_ajax();">'
				listHtml += '<div>'
				listHtml += '<p><strong>${uid}</strong></p>'
				listHtml += '<input type="hidden" id="grp" name="grp" value="'+rno+'">'
				listHtml += '<input type="hidden" id="grps" name="grps" value="'+grps+'">'
				listHtml += '<input type="hidden" id="bno" name="bno" value="${detail.num}">'
				listHtml += '<input type="hidden" id="uid" name="uid" value="${uid}">'
				listHtml += '<textarea rows="4" cols="50" id="rcmt" name="cmt" placeholder="댓글입력.."></textarea>'
				listHtml += '<button type="submit">등록</button>'
				listHtml += '</div>'
				listHtml += '</form>'
				$('#reReply'+rno+grps).html(listHtml);
			}
			
			function reReply_ajax(){
				var rcmt = $('#rcmt').val();
				if(rcmt == ""){
					alert("내용을 입력해 주세요");
					return false;
				}
				var serForm = $('#reReplyForm').serialize();
				$.ajax({
					url 		: "/reply_add",
					method 		: 'post',
					cache 		: false,
					dataType 	: "json",
					data		: serForm,
					success:function(res){
						alert(res.added ? "작성 완료":"작성 실패");
						location.href="/bbs_detail/${detail.num}";
					},
					error:function(xhr, status, err){
						alert(err);
					}
				});
				return false;
			}
			function repDelete(rno, bno, grp){
				if(!confirm("댓글을 삭제하시겠습니까?")){
					return false;
				}
				var obj = {};
				obj.rno = rno;
				obj.bno = bno;
				obj.grp = grp;
				$.ajax({
					url:"/reply_delete",
					method:'post',
					cache:false,
					dataType:"json",
					data:obj,
					success:function(res){
						alert(res.deleted ? "삭제 완료":"삭제 실패");
						location.href="/bbs_detail/"+bno;
					},
					error:function(xhr, status, err){
						alert(err);
					}
				});
			}
			
			function like(bno, uid){
				if(uid == ""){
					alert("로그인 후 이용 가능합니다");
					location.href="/login";
					return false;
				}
				var obj = {};
				obj.bno = bno;
				obj.like_uid = uid;
				
				$.ajax({
					url 		: "/like_push",
					method 		: 'post',
					cache 		: false,
					dataType 	: "json",
					data		: obj,
					success:function(res){
						location.href="/bbs_detail/${detail.num}";
					},
					error:function(xhr, status, err){
						alert(err);
					}
				});
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
					<div class="container">
					    <table class="table table-bordered ">
					        <colgroup>
					            <col width="15%">
					            <col width="35%">
					            <col width="15%">
					            <col width="*">
					        </colgroup>
					        
					        <tbody>
					            <tr>
					                <th>제목</th>
					                <td>${detail.title}</td>
					                <th>조회수</th>
					                <td>${detail.cnt}</td>
					            </tr>
					            <tr>
					                <th>작성자</th>
					                <td>${detail.name}</td>
					                <th>작성일</th>
					                <td>${detail.date}</td>
					            </tr>
					            <tr>
					                <th>내용</th>
					                <td colspan="3"> <pre>${detail.content}</pre></td>
					            </tr>
					        </tbody>
					    </table>
					    
					    <a href="/bbs_list/1" class="btn btn-outline-primary btn-sm">목록</a>
					    
					    <!-- 작성자와 로그인유저가 동일 유저라면 수정, 삭제 활성화  -->
					    <c:set value="${uid}" var="uid"/>
					    <c:set value="${detail.uid}" var="duid"/>
					    <c:if test="${uid==duid}">
    					    <button type="button" onclick="edit(${detail.num});" class="btn btn-outline-primary btn-sm">수정</button>
    					    <button type="button" onclick="del(${detail.num},'${detail.uid}');" class="btn btn-outline-primary btn-sm">삭제</button>
					    </c:if>
					    <!-- end -->
					    <button type="button" onclick="like(${detail.num},'${uid}')" class="btn btn-danger btn-sm">♥ ${detail.liked} </button>
					    
					    <br>
                        <!-- Comments section-->
	                    <section class="mb-5">
	                        <div class="card bg-light">
	                            <div class="card-body">
	                                <!-- Comment form-->
	                                <form class="mb-4"><textarea class="form-control" rows="3" placeholder="Join the discussion and leave a comment!"></textarea></form>
	                                <!-- Comment with nested comments-->
	                                <div class="d-flex mb-4">
	                                    <!-- Parent comment-->
	                                    <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
	                                    <div class="ms-3">
	                                        <div class="fw-bold">Commenter Name</div>
	                                        If you're going to lead a space frontier, it has to be government; it'll never be private enterprise. Because the space frontier is dangerous, and it's expensive, and it has unquantified risks.
	                                        <!-- Child comment 1-->
	                                        <div class="d-flex mt-4">
	                                            <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
	                                            <div class="ms-3">
	                                                <div class="fw-bold">Commenter Name</div>
	                                                And under those conditions, you cannot establish a capital-market evaluation of that enterprise. You can't get investors.
	                                            </div>
	                                        </div>
	                                        <!-- Child comment 2-->
	                                        <div class="d-flex mt-4">
	                                            <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
	                                            <div class="ms-3">
	                                                <div class="fw-bold">Commenter Name</div>
	                                                When you put money directly to a problem, it makes a good headline.
	                                            </div>
	                                        </div>
	                                    </div>
	                                </div>
	                                <!-- Single comment-->
	                                <div class="d-flex">
	                                    <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div>
	                                    <div class="ms-3">
	                                        <div class="fw-bold">Commenter Name</div>
	                                        When I look at the universe and all the ways the universe wants to kill us, I find it hard to reconcile that with statements of beneficence.
	                                    </div>
	                                </div>
	                            </div>
	                        </div>
	                    </section>
					    <!-- Comments section end-->
					    <br>
					    
					    <!-- 댓글 등록 폼-->
						<c:choose>
							<c:when test="${uid==null}">
								<p>
									<textarea rows="3" cols="80" id="cmt" name="cmt" placeholder="로그인 후 작성가능합니다..." disabled></textarea>
									<a href="/login" class="btn btn-primary btn-sm">로그인</a>
								</p>
							</c:when>
							<c:otherwise>
								<form id="replyForm" onsubmit="return reply_ajax();"> 
									<div>
										<p><strong>${uid}</strong></p>
										<input type="hidden" id="bno" name="bno" value="${detail.num}">
										<input type="hidden" id="uid" name="uid" value="${uid}">
										<textarea rows="3" cols="80" id="cmt" name="cmt" placeholder="댓글을 작성해주세요.."></textarea>
										<button type="submit" class="btn btn-primary btn-sm">작성</button>
									</div>
								</form>
							</c:otherwise>
						</c:choose>
						
						<!-- 댓글 목록 -->
						<c:forEach var="r" items="${reply}">
						<c:set value="${r.uid}" var="ruid" />
						<c:set value="${r.grp}" var="grp" />
						<c:set value="${r.rno}" var="rno" />
						<c:set value="${r.cmt}" var="cmt" />
							<c:if test="${grp == null}" >	<!-- 모댓글 -->
								<p>
									<strong>${r.uid}</strong>&nbsp;${r.repDate}
									
									<!-- 비로그인 상태일 때 댓글 목록 -->
									<c:if test="${uid==null}">
										<c:if test="${cmt==''}">
											<p style="color:#808080;">삭제된 메세지 입니다.
										</c:if>
										<p>${r.cmt}
									</c:if>
									
									<!-- 로그인 후 로그인유저가 작성하지 않은 댓글 -->
									<c:if test="${uid!=ruid and uid!=null}">
										<a href="javascript:reRep(${r.rno},${r.grps},'${ruid}');">[답글]</a>
										<c:if test="${cmt==''}">
											<p style="color:#808080;">삭제된 메세지 입니다.
										</c:if>
										<p>${r.cmt}
										<span id="reReply${r.rno}${r.grps}"></span>
									</c:if>
									
									<!-- 로그인 후 로그인유저가 작성한 댓글 -->
									<c:if test="${uid==ruid}">
										<a href="javascript:reRep(${rno},${r.grps},'${ruid}');">[답글]</a>
										<a href="javascript:repDelete(${rno},${r.bno},${r.grp})">[삭제]</a>
										<c:if test="${cmt==''}">
											<p style="color:#808080;">삭제된 메세지 입니다.
										</c:if>
										<p>${r.cmt}
										<span id="reReply${r.rno}${r.grps}"></span>
									</c:if>
								</p>
								
							</c:if>
							
							<c:if test="${grp != null}" > <!-- 대댓글 -->
								<div style="font-size: 1em; color:green;">
									<p>
										&nbsp;&nbsp;└<strong>${r.uid}</strong>&nbsp;${r.repDate}
										
										<!-- 비로그인 상태일 때 댓글 목록 -->
										<c:if test="${uid==null}">
											<c:if test="${cmt==''}">
												<p style="color:#808080;">&nbsp;&nbsp;&nbsp;&nbsp;삭제된 메세지 입니다.
											</c:if>
											<p>&nbsp;&nbsp;&nbsp;&nbsp;${r.cmt}
										</c:if>
										
										<!-- 로그인 후 로그인유저가 작성하지 않은 댓글 -->
										<c:if test="${uid!=ruid and uid!=null}">
											<a href="javascript:reRep(${r.grp},${r.grps},'${ruid}');">[답글]</a>
											<c:if test="${cmt==''}">
												<p style="color:#808080;">&nbsp;&nbsp;&nbsp;&nbsp;삭제된 메세지 입니다.
											</c:if>
											<p>&nbsp;&nbsp;&nbsp;&nbsp;${r.cmt}
											<span id="reReply${r.grp}${r.grps}"></span>
										</c:if>
										
										<!-- 로그인 후 로그인유저가 작성한 댓글 -->
										<c:if test="${uid==ruid}">
											<a href="javascript:reRep(${r.grp},${r.grps},'${ruid}');">[답글]</a>
											<a href="javascript:repDelete(${rno},${r.bno},${r.grp})">[삭제]</a>
											<c:if test="${cmt==''}">
												<p style="color:#808080;">&nbsp;&nbsp;&nbsp;&nbsp;삭제된 메세지 입니다.
											</c:if>
											<p>&nbsp;&nbsp;&nbsp;&nbsp;${r.cmt}
											<span id="reReply${r.grp}${r.grps}"></span>
										</c:if>
									</p>
								</div>
							</c:if>
						</c:forEach> 
						<!-- 댓글 목록 end -->
					</div>    
				</main>
				<jsp:include page="/WEB-INF/footer.jsp"></jsp:include>
			</div>
		</div>
		<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="js/scripts.js"></script>
	</body>
</html>