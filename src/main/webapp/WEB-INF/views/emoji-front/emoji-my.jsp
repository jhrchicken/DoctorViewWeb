<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<main id="container">
	<div class="content">
		<div class="content_inner">
			<h2>이모지 변경</h2>
			<div class="emoji">
				<ul class="emoji_inner">
					<li>
						<h3 class="user_name">${ userId }</h3>
						<div class="emoji_wrap">
							<p>${ userEmoji }</p>
						</div>
						<c:if test="${ not empty memberDTO.point }">
						    <p>보유 포인트: ${ memberDTO.point }p</p>
						</c:if>
						<c:if test="${ empty memberDTO.point }">
						    <p>보유 포인트: 0 p</p>
						</c:if>
						<div class="a_btn">
							<a href="/store.do">상점으로 이동</a>
						</div>
					</li>
					
					<c:forEach items="${ emojiDTO }" var="row" varStatus="loop">
						<form action="/emoji/editEmoji.do" method="post">
							<input type="hidden" name="emoji_idx" value="${ row.emoji_idx }" />
						    <input type="hidden" name="user_ref" value="${ row.user_ref }" />
						    <input type="hidden" name="emoji" value="${ row.emoji }" />
						    <input type="hidden" name="title" value="${ row.title }" />
						    <input type="hidden" name="use_emoji" value="${ row.use_emoji }" />
							
							<li class="your_emoji">
								<div class="have">
									<div class="emoji_wrap">
					            		<h4>${ row.emoji }</h4>
									</div>
									<p>${ row.title }</p>
						  	 	</div>
						  	 	<button type="button">변경</button>
							</li>
			
							<!-- 현재 활성화 상태 이모지 -->
							<c:if test="${ row.use_emoji == 'T' }">
								<button type="button">사용 중</button>
			  				</c:if>
			  
			  				<!-- 현재 비활성화 상태 이모지 -->
							<c:if test="${ row.use_emoji == 'F' }">
					    		<button type="submit">사용</button>
			        		</c:if>
						</form>
					</c:forEach>
				</ul>
			</div>
		</div>
	</div>
</main>