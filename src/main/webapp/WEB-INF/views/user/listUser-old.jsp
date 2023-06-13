<%@ page contentType="text/html; charset=EUC-KR" %>
<%@ page pageEncoding="EUC-KR"%>

<!--  ///////////////////////// JSTL  ////////////////////////// -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<!DOCTYPE html>

<html lang="ko">

<head>
  <meta charset="EUC-KR">

  <!-- ���� : http://getbootstrap.com/css/   ���� -->
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />

  <!--  ///////////////////////// Bootstrap, jQuery CDN ////////////////////////// -->
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" >
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" >
  <script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" ></script>


  <!-- Bootstrap Dropdown Hover CSS -->
<%--  <link href="/css/animate.min.css" rel="stylesheet">--%>
<%--  <link href="/css/bootstrap-dropdownhover.min.css" rel="stylesheet">--%>
  <!-- Bootstrap Dropdown Hover JS -->
<%--  <script src="/javascript/bootstrap-dropdownhover.min.js"></script>--%>


  <!-- jQuery UI toolTip ��� CSS-->
  <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <!-- jQuery UI toolTip ��� JS-->
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

  <!--  ///////////////////////// CSS ////////////////////////// -->
  <style>
    body {
      padding-top : 50px;
    }
  </style>

  <!--  ///////////////////////// JavaScript ////////////////////////// -->
  <script type="text/javascript">

    //=============    �˻� / page �ΰ��� ��� ���  Event  ó�� =============
    function fncGetList(currentPage) {
      $("#currentPage").val(currentPage)
      $("form").attr("method" , "POST").attr("action" , "/user/listUser").submit();
    }


    //============= "�˻�"  Event  ó�� =============
    $(function() {
      //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
      //$( "button.btn.btn-default" ).on("click" , function() {
      //	fncGetUserList(1);
      //});
      $("#search").on("click" , function() {
        //Debug..
        //alert(  $( "td.ct_btn01:contains('�˻�')" ).html() );
        fncGetList(${ search.currentPage })
      });

      $("#searchKeyword").on("keydown", function(e) {
        if (e.keyCode == 13) {
          e.preventDefault();
          fncGetList(${ search.currentPage })
        };
      });
    });


    //============= userId �� ȸ����������  Event  ó��(Click) =============
    $(function() {

      //==> DOM Object GET 3���� ��� ==> 1. $(tagName) : 2.(#id) : 3.$(.className)
      $( ".getUser" ).on("click" , function() {
        console.log("ȸ��ID Ŭ����"+$(this).text().trim());
        self.location ="/user/getUser?userId="+$(this).text().trim();
      });

      //==> userId LINK Event End User ���� ���ϼ� �ֵ���
      $( "td:nth-child(2)" ).css("color" , "red");
    });

  </script>

</head>

<body>

<!--  ȭ�鱸�� div Start /////////////////////////////////////-->
<div class="container">

  <div class="page-header text-info">
    <h3>ȸ�������ȸ</h3>
  </div>

  <!-- table ���� �˻� Start /////////////////////////////////////-->
  <div class="row">

    <div class="col-md-6 text-left">
      <p class="text-primary">
        ��ü  ${resultPage.totalCount } �Ǽ�, ���� ${resultPage.currentPage}  ������
      </p>
    </div>

    <div class="col-md-6 text-right">
      <form class="form-inline" name="detailForm">

        <div class="form-group">
          <select class="form-control" name="searchCondition" >
            <option value="0"  ${ ! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>ȸ��ID</option>
            <option value="1"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>ȸ����</option>
            <option value="2"  ${ ! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>�г���</option>
          </select>
        </div>

        <div class="form-group">
          <label class="sr-only" for="searchKeyword">�˻���</label>
          <input type="text" class="form-control" id="searchKeyword" name="searchKeyword"  placeholder="�˻���"
                 value="${! empty search.searchKeyword ? search.searchKeyword : '' }"  >
        </div>

        <button type="button" class="btn btn-default" id="search">�˻�</button>

        <!-- PageNavigation ���� ������ ���� ������ �κ� -->
        <input type="hidden" id="currentPage" name="currentPage" value=""/>

      </form>
    </div>

  </div>
  <!-- table ���� �˻� Start /////////////////////////////////////-->


  <!--  table Start /////////////////////////////////////-->
  <table class="table table-hover table-striped" >

    <thead>
    <tr>
      <th align="center">No</th>
      <th align="left" >ȸ�� ID</th>
      <th align="left">�̸�</th>
      <th align="left">�г���</th>
      <th align="left">��������</th>
      <th align="left">Ż������</th>
    </tr>
    </thead>

    <tbody>

    <c:set var="i" value="0" />
    <c:forEach var="user" items="${list}">
      <c:set var="i" value="${ i+1 }" />
      <tr>
        <td align="center">${ i }</td>
        <td align="left"  class="getUser">${user.userId}</td>
        <td align="left">${user.userName}</td>
        <td align="left">${user.nickname}</td>
        <td align="left">${user.userRegDate}</td>
        <td align="left">${user.secession}</td>
      </tr>
    </c:forEach>

    </tbody>

  </table>
  <!--  table End /////////////////////////////////////-->

</div>
<!--  ȭ�鱸�� div End /////////////////////////////////////-->


<!-- PageNavigation Start... -->
<jsp:include page="../user/pageNavigator.jsp"/>
<!-- PageNavigation End... -->

</body>

</html>