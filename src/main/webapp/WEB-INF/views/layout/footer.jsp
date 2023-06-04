<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<footer id="footer">

    <div class="container">

        <div class="row">

            <!-- 메모 -->
            <div class = left-section>
                <c:if test="${empty sessionScope.user}">
                    로그인되지 않은 사람은 메모를 사용할 수 없습니다.
                </c:if>
                <c:if test="${not empty sessionScope.user}">
                    <form id="memoListForm">
                        <input type="text" id="memoUserId" value="${sessionScope.user.userId}" readonly><br/>
                        <input type="text" id="memoSearchCondition" value="${empty sessionScope.memoPage.searchCondition ? 'myMemo' : sessionScope.memoPage.searchCondition}" readonly><br/>
                        <input type="text" id="memoCurrentPage" value="${empty sessionScope.memoPage.currentPage ? '1' : sessionScope.memoPage.currentPage}" readonly><br/>
                        <input type="text" id="memoDialogCount" value="${empty sessionScope.memoPage.dialogCount ? '0' : sessionScope.memoPage.dialogCount}" readonly><br/>
                        <button type="button" id="memoListToggleBtn" class="btn btn-primary" onclick="toggleMemo()">메모 토글</button>
                        <br/>
                        <br/>
                        <div id="memoListSection">
                            <div id="memoListArea">

                            </div>
                            <br/>
                            <br/>
                            <div id="memoSearchArea">
                                <button type="button" class="memoSearchBtn" id="myMemo">내 메모 보기</button>
                                <button type="button" class="memoSearchBtn" id="sharedMemo">공유받은 메모 보기</button>
                                <button type="button" class="memoSearchBtn" id="deletedMemo">삭제된 메모 보기</button>
                                <button type="button" class="addMemoBtn" id="addMemo">새 메모</button>
                            </div>
                        </div>
                    </form>
                </c:if>
            </div>
            <div class = "middle-section">
                <div id="memoModalArea">
                    <div id="memoShareListModal"></div>
                </div>
                <div id="memoDialogsArea">
                    <form class="memoDialog" name="memoDialogCount">
                        <div id="memoDetailArea">

                        </div>
                        <div id="memoControlArea">

                        </div>
                    </form>
                </div>
            </div>

            <!-- 챗봇 -->
            <div class = "right-section">
                <div id="root"></div>
                <script src="/js/bot/bot.js"></script>
                <link href="/css/bot/bot.css" rel="stylesheet">
            </div>

        </div>

        <div class="search-bar padding-20">

            <div class="row">

                <div class="col-md-4 form-group">

                    <label for="price">여행지</label>

                    <select class="form-control" id="price">

                        <option value="">서울</option>
                        <option value="">제주</option>

                    </select>

                </div>

                <div class="col-md-4 form-group">

                    <label for="from">시작일</label>
                    <input type="text" class="form-control datepicker" id="from" readonly>

                </div>

                <div class="col-md-4 form-group">

                    <label for="to">종료일</label>
                    <input type="text" class="form-control datepicker" id="to" readonly>

                </div>

            </div>

            <div class="col-md-2">

                <button class="btn btn-primary btn-search hvr-sweep-to-right">Search</button>

            </div>

        </div>

    </div>

    <div class="copy"><span>&copy;</span> Copyright BitCamp MoTrip, 2023</div>

</footer>