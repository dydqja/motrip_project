<li class= "nav-item dropdown" id="alarm-set-area">
    <div id="alarm-modal-area">
    </div>
    <div class="alarm-info-area">
        <%--어플리케이션 스코프로부터 값을 받거나, 3이다.--%>
        <input type="hidden" id="pollingTime" value="${applicationScope.alarmPollingTime}">
        <input type="hidden" id="alarmUserId" value="${sessionScope.user.userId}">
        <input type="hidden" id="alarmCurrentPage" value="1">
    </div>
    <span class="icon-bell" style="position: relative;"></span>
    <span class="badge bg-danger" id="unreadAlarmCount">0</span>
    <ul id="alarm-thumbnail-area" class="dropdown-menu  dropdown-menu-left cart-menu">
        <li class="dropdown-header">
            <a href="" id="getAlarmListBtn" class="btn btn-line btn-primary hvr-underline-from-center" style="width: 50%;">최근 알람</a>
            <a href="" id="getHoldAlarmListBtn" class="btn btn-line btn-primary hvr-underline-from-center" style="width: 50%;">보류 알람</a>
        </li>
        <li class="alarm-thumbnail">
            <img src="http://placehold.it/40x40" alt="" class="item-img">
            <span class="delete icon-trash"></span>
            <div class="text">
                Lorem ipsum dolor sit amet, consectetur.
                <p>USD 473 X 2</p>
            </div>
        </li>
        <li class="alarm-thumbnail">
            <img src="http://placehold.it/40x40" alt="" class="item-img">
            <span class="delete icon-trash"></span>
            <div class="text">
                Lorem ipsum dolor sit amet, consectetur.
                <p>USD 473 X 2</p>
            </div>
        </li>
        <li class="alarm-thumbnail">
            <img src="http://placehold.it/40x40" alt="" class="item-img">
            <span class="delete icon-trash"></span>
            <div class="text">
                Lorem ipsum dolor sit amet, consectetur.
                <p>USD 473 X 2</p>
            </div>
        </li>
    </ul>
</li>