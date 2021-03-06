<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>휴가 현황</title>
    <link href="${pageContext.request.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/fullcalendar.min.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/vendor/bootstrap.min.css">
    <link rel="stylesheet" href='${pageContext.request.contextPath}/resources/vendor/select2.min.css' />
    <link rel="stylesheet" href='${pageContext.request.contextPath}/resources/vendor/bootstrap-datetimepicker.min.css' />
	

    <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Open+Sans:400,500,600">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
	
	<script src="${pageContext.request.contextPath}/resources/js/jquery-3.5.1.js"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css">
    <style>
        *{
            margin : 0;
        }
        body{
            width : 100%;
            height: 100%;
            position: relative;
            font-size: 14px;
            font-family: Noto Sans KR;
            line-height: 1.15;
        }
        .header{
            position: relative;
            width: 100%;
            height: 60px;
        }
        .header div{
            width: 1200px;
            height: 60px;
            margin: 0 auto;
        }
        /* 본문 */
        .main{
            position: relative;
            width: 1200px;
            height: 100%;
            margin: 0 auto;
        }
        /* 사이드메뉴 */
        .sidenav{
            position: relative;
            width: 210px;
            height: 100%;
            float: left;
        }
        .sidenav ul,
        .sidenav ul li a {
            display: block;
            color: black;
        }
        .sidenav ul li{
            display: block;
            font-size: 16px;
        }
        .sidenav ul ul {
        display: none;
        }
        .sidenav > ul > li > a {
        padding: 19px 20px;
        z-index: 2;  
        cursor: pointer;
        font-weight: 700;
        text-decoration: none;
        }
        .sidenav ul ul li{
            background-color: #e7e7e7;
        }
        .sidenav ul ul li a {
        cursor: pointer;
        padding: 10px 0;
        padding-left: 30px;
        z-index: 1;
        text-decoration: none;
        font-size: 13px;
        }
        /* 콘텐츠 */
        .container{
            position: absolute;
            width: 970px;
            left: 210px;
            margin: 0;
            padding : 40px 0 40px 40px;
            border-left: 1px solid #e7e7e7;
        }
        .conTitle{
            width: 930px;
            line-height: 40px;
            padding-bottom: 20px;
            font-size: 32px;
            border-bottom: 2px solid #e7e7e7;
        }
        .col-lg-6{
            width: 930px;
            height: 30px;
            margin-top: 60px;
            padding: 0;
        }
        #optionTit{
            width: 70px;
            height: 30px;
            margin : 0;
            float: left;
        }
    </style>
    <script>
       
    </script>    
</head>

<body>
    <div class="header">
        <div>헤더 들어갈 자리</div>
    </div>
    <div class="main">
        <div class="sidenav">
                <ul>
                    <li class="menu"><a href="">근태 관리</a>
                        <ul class="hide">
                            <li><a href="">출퇴근 관리</a></li>
                            <li><a href="">월 근무내역</a></li>
                            <li><a href="">시간외 근무신청</a></li>
                        </ul>
                    </li>
                    <li class="menu"><a href="">휴가 관리</a>
                        <ul class="hide">
                            <li><a href="">휴가 신청</a></li>
                            <li><a href="">휴가 현황</a></li>
                        </ul>
                    </li>
                    <li ><a href="">조직도</a></li>
                </ul>
        </div>
        <div class="container">
        <div class="panel panel-default">
            <div class="conTitle">휴가 현황</div>    
            <div class="panel-body">
                <!-- <div class="col-lg-6">
                    <label for="calendar_view">구분별</label>
                    <div class="input-group">
                        <select class="filter" id="type_filter" multiple="multiple">
                            <option value="카테고리1">카테고리1</option>
                            <option value="카테고리2">카테고리2</option>
                            <option value="카테고리3">카테고리3</option>
                            <option value="카테고리4">카테고리4</option>
                        </select>
                    </div>
                </div> -->

                <div class="col-lg-6">
                    <div id="optionTit" style="font-weight : 700;">부서구분</div>
                    <div class="input-group">
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="정연"
                            checked>전체선택</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="정연"
                                checked>경영팀</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="다현"
                                checked>인사팀</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="사나"
                                checked>개발팀</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="나연"
                                checked>영업팀</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="지효"
                                checked>디자인팀</label>
                        <label class="checkbox-inline"><input class='filter' type="checkbox" value="정연"
                                checked>마케팅</label>
                    </div>
                </div>

            </div>
        </div>

        <div id="wrapper">
            <div id="loading"></div>
            <div id="calendar"></div>
        </div>


        <!-- 일정 추가 MODAL -->
        <div class="modal fade" tabindex="-1" role="dialog" id="eventModal">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                                aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title"></h4>
                    </div>
                    <div class="modal-body">

                        <!-- <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-allDay">하루종일</label>
                                <input class='allDayNewEvent' id="edit-allDay" type="checkbox"></label>
                            </div>
                        </div> -->

                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-title">이름</label>
                                <input class="inputModal" type="text" name="edit-title" id="edit-title"
                                    required="required" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-type">부서명</label>
                                <select class="inputModal" type="text" name="edit-type" id="edit-type">
                                    <option value="카테고리1">카테고리1</option>
                                    <option value="카테고리2">카테고리2</option>
                                    <option value="카테고리3">카테고리3</option>
                                    <option value="카테고리4">카테고리4</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-start">휴가 시작일</label>
                                <input class="inputModal" type="text" name="edit-start" id="edit-start" />
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-end">휴가 종료일</label>
                                <input class="inputModal" type="text" name="edit-end" id="edit-end" />
                            </div>
                        </div>
                        
                        <!-- <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-color">색상</label>
                                <select class="inputModal" name="color" id="edit-color">
                                    <option value="#D25565" style="color:#D25565;">빨간색</option>
                                    <option value="#9775fa" style="color:#9775fa;">보라색</option>
                                    <option value="#ffa94d" style="color:#ffa94d;">주황색</option>
                                    <option value="#74c0fc" style="color:#74c0fc;">파란색</option>
                                    <option value="#f06595" style="color:#f06595;">핑크색</option>
                                    <option value="#63e6be" style="color:#63e6be;">연두색</option>
                                    <option value="#a9e34b" style="color:#a9e34b;">초록색</option>
                                    <option value="#4d638c" style="color:#4d638c;">남색</option>
                                    <option value="#495057" style="color:#495057;">검정색</option>
                                </select>
                            </div>
                        </div> -->
                        <div class="row">
                            <div class="col-xs-12">
                                <label class="col-xs-4" for="edit-desc">휴가 형태</label>
                                <textarea rows="4" cols="50" class="inputModal" name="edit-desc"
                                    id="edit-desc"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer modalBtnContainer-addEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                        <button type="button" class="btn btn-primary" id="save-event">저장</button>
                    </div>
                    <div class="modal-footer modalBtnContainer-modifyEvent">
                        <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
                        <button type="button" class="btn btn-danger" id="deleteEvent">삭제</button>
                        <button type="button" class="btn btn-primary" id="updateEvent">저장</button>
                    </div>
                </div><!-- /.modal-content -->
            </div><!-- /.modal-dialog -->
        </div><!-- /.modal -->
        </div><!-- /.container -->    
    </div>
    <script src="${pageContext.request.contextPath}/resources/vendor/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/js/bootstrap.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/js/moment.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/js/fullcalendar.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/js/ko.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/js/select2.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/vendor/js/bootstrap-datetimepicker.min.js"></script>

    <script src="${pageContext.request.contextPath}/resources/js/addEvent.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/editEvent.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/etcSetting.js"></script>
    <script>
    
    // html dom 이 다 로딩된 후 실행된다.
   
    $('.sidenav li.menu>a').on('click', function(){
	$(this).removeAttr('href');
	var element = $(this).parent('li');
	if (element.hasClass('open')) {
		element.removeClass('open');
		element.find('li').removeClass('open');
        element.find('ul').slideUp();
	}
	else {
		element.addClass('open');
		element.children('ul').slideDown();
		element.siblings('li').children('ul').slideUp();
		element.siblings('li').removeClass('open');
		element.siblings('li').find('li').removeClass('open');
        element.siblings('li').find('ul').slideUp();
	}
    });

    
        var draggedEventIsAllDay;
var activeInactiveWeekends = true;

var calendar = $('#calendar').fullCalendar({

 /** ******************
   *  OPTIONS
   * *******************/
    
  timezone                  : "local", 
  nextDayThreshold          : "09:00:00",
  allDaySlot                : true,
  displayEventTime          : true,
  displayEventEnd           : true,
  firstDay                  : 0, //월요일이 먼저 오게 하려면 1
  weekNumbers               : false,
  selectable                : true,
  weekNumberCalculation     : "ISO",
  eventLimit                : true,
  views                     : { 
                                month : { eventLimit : 12 } // 한 날짜에 최대 이벤트 12개, 나머지는 + 처리됨
                              },
  eventLimitClick           : 'week', //popover
  navLinks                  : true,
  defaultDate               : moment('2021-01'), //실제 사용시 현재 날짜로 수정
  timeFormat                : 'HH:mm',
  defaultTimedEventDuration : '01:00:00',
  editable                  : true,
  minTime                   : '00:00:00',
  maxTime                   : '24:00:00',
  slotLabelFormat           : 'HH:mm',
  weekends                  : true,
  nowIndicator              : true,
  dayPopoverFormat          : 'yyyy-mm-dd',
  
  longPressDelay            : 0,
  eventLongPressDelay       : 0,
  selectLongPressDelay      : 0,  
  header                    : {
                                left   : 'today, prevYear, nextYear, viewWeekends',
                                center : 'prev, title, next',
                                right  : 'month, agendaWeek, agendaDay, listWeek'
                              },
  views                     : {
                                month : {
                                  columnFormat : 'dddd'
                                },
                                agendaWeek : {
                                  columnFormat : 'yyyy-mm-dd',
                                  titleFormat  : 'yyyy-mm-dd',
                                  eventLimit   : false
                                },
                                agendaDay : {
                                  columnFormat : 'dddd',
                                  eventLimit   : false
                                },
                                listWeek : {
                                  columnFormat : ''
                                }
                              },
  customButtons             : { //주말 숨기기 & 보이기 버튼
                                viewWeekends : {
                                  text  : '주말',
                                  click : function () {
                                    activeInactiveWeekends ? activeInactiveWeekends = false : activeInactiveWeekends = true;
                                    $('#calendar').fullCalendar('option', { 
                                      weekends: activeInactiveWeekends
                                    });
                                  }
                                }
                               },


  eventRender: function (event, element, view) {

    //일정에 hover시 요약
    element.popover({
      title: $('<div />', {
        class: 'popoverTitleCalendar',
        text: event.title
      }).css({
        'color': event.textColor
      }),
      content: $('<div />', {
          class: 'popoverInfoCalendar'
        }).append('<p><strong>등록자:</strong> ' + event.username + '</p>')
        .append('<p><strong>구분:</strong> ' + event.type + '</p>')
        .append('<p><strong>시간:</strong> ' + getDisplayEventDate(event) + '</p>')
        .append('<div class="popoverDescCalendar"><strong>설명:</strong> ' + event.description + '</div>'),
      delay: {
        show: "800",
        hide: "50"
      },
      trigger: 'hover',
      placement: 'top',
      html: true,
      container: 'body'
    });

    return filtering(event);

  },

  /* ****************
   *  일정 받아옴 
   * ************** */
  events: function (start, end, callback) {
	  console.log(start);
    $.ajax({
    	contentType:'application/json',
      type: "get",
      url: "${pageContext.request.contextPath}/dayoff/calendar",
      dataType : "json",
      success: function (response) {
		        
        var fixedDate = response.map(function (array) {
        	console.log(array);
        	var enddate=array.offend;
            var startdate=array.offstart;
        	var array1 = enddate.replace("월", ",");
            var array2 = startdate.replace("월", ",");
            
          if (array.allDay && array.start !== array.end) {
            array.end = moment(array.end).add(1, 'days'); // 이틀 이상 AllDay 일정인 경우 달력에 표기시 하루를 더해야 정상출력
          }
          return array;
        });
         console.log("수정" + fixedDate);
        function callback(fixedDate){};
        /* function successCallback(events) {   //events 사용 구문   } */
      }
    });
  },

  eventAfterAllRender: function (view) {
    if (view.name == "month") $(".fc-content").css('height', 'auto');
  },

  //일정 리사이즈
  eventResize: function (event, delta, revertFunc, jsEvent, ui, view) {
    $('.popover.fade.top').remove();

    /** 리사이즈시 수정된 날짜반영
     * 하루를 빼야 정상적으로 반영됨. */
    var newDates = calDateWhenResize(event);

    //리사이즈한 일정 업데이트
    $.ajax({
      type: "get",
      url: "",
      data: {
        //id: event._id,
        //....
      },
      success: function (response) {
        alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
      }
    });

  },

  eventDragStart: function (event, jsEvent, ui, view) {
    draggedEventIsAllDay = event.allDay;
  },

  //일정 드래그앤드롭
  eventDrop: function (event, delta, revertFunc, jsEvent, ui, view) {
    $('.popover.fade.top').remove();

    //주,일 view일때 종일 <-> 시간 변경불가
    if (view.type === 'agendaWeek' || view.type === 'agendaDay') {
      if (draggedEventIsAllDay !== event.allDay) {
        alert('드래그앤드롭으로 종일<->시간 변경은 불가합니다.');
        location.reload();
        return false;
      }
    }

    // 드랍시 수정된 날짜반영
    var newDates = calDateWhenDragnDrop(event);

    //드롭한 일정 업데이트
    $.ajax({
      type: "get",
      url: "",
      data: {
        //...
      },
      success: function (response) {
        alert('수정: ' + newDates.startDate + ' ~ ' + newDates.endDate);
      }
    });

  },

  select: function (startDate, endDate, jsEvent, view) {
	console.log("여기" + startDate);
    $(".fc-body").unbind('click');
    $(".fc-body").on('click', 'td', function (e) {

      $("#contextMenu")
        .addClass("contextOpened")
        .css({
          display: "block",
          left: e.pageX,
          top: e.pageY
        });
      return false;
    });

    var today = moment();

    if (view.name == "month") {
      startDate.set({
        hours: today.hours(),
        minute: today.minutes()
      });
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
      endDate = moment(endDate).subtract(1, 'days');

      endDate.set({
        hours: today.hours() + 1,
        minute: today.minutes()
      });
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
    } else {
      startDate = moment(startDate).format('YYYY-MM-DD HH:mm');
      endDate = moment(endDate).format('YYYY-MM-DD HH:mm');
    }

    //날짜 클릭시 카테고리 선택메뉴
    var $contextMenu = $("#contextMenu");
    $contextMenu.on("click", "a", function (e) {
      e.preventDefault();

      //닫기 버튼이 아닐때
      if ($(this).data().role !== 'close') {
        newEvent(startDate, endDate, $(this).html());
      }

      $contextMenu.removeClass("contextOpened");
      $contextMenu.hide();
    });

    $('body').on('click', function () {
      $contextMenu.removeClass("contextOpened");
      $contextMenu.hide();
    });

  },

  //이벤트 클릭시 수정이벤트
  eventClick: function (event, jsEvent, view) {
    editEvent(event);
  }

});

function getDisplayEventDate(event) {

  var displayEventDate;

  if (event.allDay == false) {
    var startTimeEventInfo = moment(event.start).format('HH:mm');
    var endTimeEventInfo = moment(event.end).format('HH:mm');
    displayEventDate = startTimeEventInfo + " - " + endTimeEventInfo;
  } else {
    displayEventDate = "하루종일";
  }	
  return displayEventDate;
 	console.log("너" + displayEventDate);
}

 function filtering(event) {
  var show_username = false;
  var show_type = false;

  var username = $('input:checkbox.filter:checked').map(function () {
    return $(this).val();
  }).get();
  var types = $('#type_filter').val();

   show_username = username.indexOf(event.username) >= 0; 

   if (types && types.length > 0) {
	if (types[0] == "all") {
      show_type = true;
    } else {
      show_type = true;
    } 
  } 
   return true;
   
   /* return show_username && show_type; */ 
}

function calDateWhenResize(event) {

  var newDates = {
    startDate: '',
    endDate: ''
  };

  if (event.allDay) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
  } else {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
  }

  return newDates;
}

function calDateWhenDragnDrop(event) {
  // 드랍시 수정된 날짜반영
  var newDates = {
    startDate: '',
    endDate: ''
  }

  // 날짜 & 시간이 모두 같은 경우
  if(!event.end) {
    event.end = event.start;
  }

  //하루짜리 all day
  if (event.allDay && event.end === event.start) {
    console.log('1111')
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = newDates.startDate;
  }

  //2일이상 all day
  else if (event.allDay && event.end !== null) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD');
    newDates.endDate = moment(event.end._d).subtract(1, 'days').format('YYYY-MM-DD');
  }

  //all day가 아님
  else if (!event.allDay) {
    newDates.startDate = moment(event.start._d).format('YYYY-MM-DD HH:mm');
    newDates.endDate = moment(event.end._d).format('YYYY-MM-DD HH:mm');
  }

  return newDates;
}

    </script>
</body>

</html>