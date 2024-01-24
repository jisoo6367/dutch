/**
 * mycomment.js: 댓글/답글 데이터 처리용 Ajax Closure Module
*/
//alert("댓글 클로저 모듈 실행됨========") ;	

var dutchReplyClsr = (function(){

	//댓글 목록(페이징) - ajax() 함수 사용
    function getCmtList(myParam, callback, error) {
        var pno = myParam.pno ;
        var pageNum = (myParam.pageNum != null)? myParam.pageNum:1
        //var pageNum = myParam.pageNum || 1 ;
        console.log("getCmtList()가 전달받은 pno: " + pno) ;
        console.log("getCmtList()가 전달받은 pageNum: " + pageNum) ;

        //댓글 목록 조회 컨트롤러의 매핑 URL: GET /dutchReplies/{pno}/page/{pageNum}
        //$.ajax() 함수는, 자바스크립트 객체를 매개값으로 받아 처리
        $.ajax({
            type: "get" ,
            url: "/dutch/dutchReplies/" + pno + "/page/" + pageNum ,
            dataType: "json" , //나는 json으로 받고 싶어
            success: function(dutchReplayPagingCreator, status){
                if(callback) {
                    callback(dutchReplayPagingCreator) ;
                }
            } ,

            error: function(xhr, status, err) {
                if(error) {
                    error(err) ;
                }
            }

        });//ajax-end

    } //getCmtList-end

    //게시물에 대한 댓글 등록
    function registerCmt(cmt, callback){

        var pno = cmt.pno ;

        $.ajax({
            type: "post" ,
            url: "/dutch/dutchReplies/" + pno + "/new" ,
            data: JSON.stringify(cmt) ,
            contentType: "application/json; charset=utf-8" ,
            dataType: "text" ,
            success: function(result, status) {
                if(callback) {
                    callback(result) ;
                }
            },
			
			error: function(xhr, status, err){
				console.log("댓글등록 시 오류 발생!!!!!!") ;
			}

        }); //ajax-end

    }//registerCmt-end

    function registerReply(reply, callback, error){

        var pno = reply.pno ;
        var rcno = reply.rcno ;

        $.ajax({
            type: "post" ,
            url: "/dutch/dutchReplies/" + pno + "/" + rcno + "/new" ,
            data: JSON.stringify(reply) ,
            contentType: "application/json; charset=utf-8" ,
            dataType: "text" ,
            success: function(result, status, xhr) {
                if(callback) {
                    callback(result) ;
                }
            } ,
            error: function(xhr, status, err) {
                if(error) {
                    error(err) ;
                }
            }

        });//ajax-end


    } //registerReply-end


    function getCmtReply(pnoAndRno, callback, error) {

        var pno = pnoAndRno.pno ;
        var rno = pnoAndRno.rno ;

        $.ajax({
            type: "get" ,
            url: "/dutch/dutchReplies/" + pno + "/" + rno ,
            dataType: "json" ,
            success: function(reply, status, xhr) {
                if(callback) {
                    callback(reply) ;
                }
            } ,
            error: function(xhr, status, err) {
                if(error) {
                    error(err) ;
                }
            }

        });//ajax-end

    }//getCmtReply-end

    function modifyCmtReply(cmtReply, callback, error) {
        var pno = cmtReply.pno ;
        var rno = cmtReply.rno ;

        $.ajax({
            type: "put" ,
            url: "/dutch/dutchReplies/" + pno + "/" + rno ,
            data: JSON.stringify(cmtReply) ,
            contentType: "application/json; charset=utf-8" ,
            dataType: "text" ,
            success: function(result, status, xhr) {
                if(callback) {
                    callback(result) ;
                }
            } ,
            error: function(xhr, status, err) {
                if(error){
                    error(err) ;
                }
            }
        }) ; //ajax-end
    }//modifyCmtReply-end


    function removeCmtReply(myReplyCmt, callback, error) {

        var pno = myReplyCmt.pno ;
        var rno = myReplyCmt.rno ;
        console.log(pno);
        console.log(rno);

        $.ajax({
            type: "DELETE" ,
            url: "/dutch/dutchReplies/" + pno + "/" + rno ,
            data: JSON.stringify(myReplyCmt) ,
            contentType: "application/json; charset=utf-8" ,
            dataType: "text" ,
            success: function(result, status, xhr) {
                if(callback) {
                    callback(result) ;
                    console.log(result);
                }
            } ,
            error: function(xhr, status, err) {
                if(error) {
                    error(err) ;
                    console.log(err);
                }
            } 

        });

    } //removeCmtReply-end


    function removeAllReply(pno, callback, error) {
        
        $.ajax({
            type: "DELETE" ,
            url: "/dutch/dutchReplies/" + pno ,
            dataType: "text" ,
            success: function(result, status, xhr) {
                if(callback) {
                    callback(result) ;
                }
            } ,
            error: function(xhr, status, err) {
                if(error) {
                    error(err) ;
                }
            } 

        });


    } //removeAllReply-end


    //날짜시간 표시형식 변경 (서버와 상관없음)
    //JSON 날짜시간을 그대로 표시하면 1594169682000 (Long 타입 정수값) 이렇게 표시됩니다.
    //일반적인 날짜 시간 형식으로 표시하는 함수를 구현
    function myDateTimeFmt(datetimeValue) {
        
        var myDate = new Date(datetimeValue) ;
//        console.log("myDate: " + myDate) ;

        var myDateTime = "" ;

        var yyyy = myDate.getFullYear() ;
        var mm = myDate.getMonth() + 1 ;  //1~12,  getMonth() is zero-based
        var dd = myDate.getDate() ;
        var hh = myDate.getHours() ;
        var mi = myDate.getMinutes() ;
        var ss = myDate.getSeconds() ;
        //2023/01/07 07:05:02
        myDateTime =   [yyyy, "/",
                       (mm > 9 ? '' : "0") + mm , "/" ,
                       (dd > 9 ? '' : "0") + dd , " " ,
                       (hh > 9 ? '' : "0") + hh , ":" ,
                       (mi > 9 ? '' : "0") + mi , ":" ,
                       (ss > 9 ? '' : "0") + ss ].join('') ;
        return myDateTime                         

    } //myDateTimeFmt-end

    return {//myReplyClsr
        getCmtList: getCmtList ,
        registerCmt: registerCmt ,
        registerReply: registerReply ,
        getCmtReply: getCmtReply ,
        modifyCmtReply: modifyCmtReply ,
        removeCmtReply: removeCmtReply ,
        removeAllReply: removeAllReply ,
        myDateTimeFmt: myDateTimeFmt
    } ;


})();