<%@page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri = "http://java.sun.com/jsp/jstl/functions" prefix = "fn" %>
<!DOCTYPE html>
<html lang="en">

	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<meta http-equiv="X-UA-Compatible" content="ie=edge" />
		<!-- <link
			rel="stylesheet"
			href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.12.1/css/all.min.css"
			integrity="sha256-mmgLkCYLUQbXn0B1SRqzHar6dCnv9oZFPEC1g1cwlkk="
			crossorigin="anonymous"
		/>
		<link rel="stylesheet" href="css/style.css" /> -->
		<title>motip</title>
	</head>
	<body>
		<div class="join-container">
			<header class="join-header">
				<h1><i class="fas fa-smile"></i> 채팅방 리스트 데수우~</h1>
			</header>
			<main class="join-main">
<%--				<form action="http://localhost:3000/chat.html" method="get">--%>
				<form action="http://localhost:8080/chatRoom/chat" method="get">
					<div class="form-control">
						<label for="username">Username(삭제예정)</label>
						<input
							type="text"
							name="username"
							id="username"
							placeholder="Enter username..."
							required
						/>
					</div>
					<div class="form-control">
						<label for="room">Room(삭제예정)</label>
						<select name="room" id="room">
							<option value="1번방">1번방</option>
							<option value="2번방">2번방</option>
							<option value="3번방">3번방</option>
						</select>
					</div>
					<table>
						<tr>
							<td class="ct_list_b" width="200">채팅방 번호</td>
							<td class="ct_line02"></td>
							<td class="ct_list_b" width="200">채팅방 이름</td>
							<td class="ct_line02"></td>
							<td class="ct_list_b" width="200">여행 시작 날짜</td>
							<td class="ct_line02"></td>
							<td class="ct_list_b" width="200">여행 플랜 번호</td>
							<td class="ct_line02"></td>
							<td class="ct_list_b" width="200">최대 인원수</td>
							<td class="ct_line02"></td>
							<td class="ct_list_b" width="200">모집 상태</td>
						</tr>
						<tr>
							<td colspan="11" bgcolor="808285" height="1"></td>
						</tr>
						<c:set var="i" value="0" />
						<c:forEach var="chatRoom" items="${list}">
							<c:set var="i" value="${ i+1 }" />
							<tr class="ct_list_pop">
								<td align="center" width="200">${chatRoom.chatRoomNo}</td>
								<td></td>
								<td align="center" width="200">${chatRoom.chatRoomTitle}</td>
								<td></td>
								<td align="center" width="200">${chatRoom.strDate}</td>
								<td></td>
								<td align="center" width="200">planTitle예정</td>
								<td></td>
								<td align="center" width="200">${chatRoom.maxPersons}</td>
								<td></td>
								<td align="center" width="200">
									<c:if test="${chatRoom.chatRoomStatus eq 0}">
										모집중
									</c:if>
									<c:if test="${chatRoom.chatRoomStatus eq 1}">
										모집완료
									</c:if>
									<c:if test="${chatRoom.chatRoomStatus eq 2}">
										여행완료
									</c:if>
								</td>
								<td></td>
								<td><button type="submit" class="btn">Join Chat</button></td>							</tr>
						</c:forEach>
					</table>
				</form>
			</main>
		</div>
	</body>
</html>