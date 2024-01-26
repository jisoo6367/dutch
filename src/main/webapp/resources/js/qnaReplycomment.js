/**
 * replycomment.js: 댓글/답글 데이터 처리용 Ajax Closure Module
*/
//alert("댓글 클로저 모듈 실행됨========") ;   

var qnaReplyClsr = (function(){

   //댓글 목록(페이징) - ajax() 함수 사용
    function getCmtList(myParam, callback, error) {
        var qno = myParam.qno ;
        var pageNum = (myParam.pageNum != null)? myParam.pageNum:1
        //var pageNum = myParam.pageNum || 1 ;
        //console.log("getCmtList()가 전달받은 qno: " + qno) ;
        //console.log("getCmtList()가 전달받은 pageNum: " + pageNum) ;

        //댓글 목록 조회 컨트롤러의 매핑 URL: GET /replies/{qno}/page/{pageNum}
        //$.ajax() 함수는, 자바스크립트 객체를 매개값으로 받아 처리
        $.ajax({
            type: "get" ,
            url: "/dutch/qnaReplies/" + qno + "/page/" + pageNum + "/qna" ,
            dataType: "json" , //나는 json으로 받고 싶어
            success: function(qnareplyPagingCreator, status){
                if(callback) {
                    callback(qnareplyPagingCreator) ;
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

        var qno = cmt.qno ;

        $.ajax({
            type: "post" ,
            url: "/dutch/qnaReplies/" + qno + "/new" + "/qna" ,
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

	//답글등록
    function registerReply(reply, callback, error){

        var qno = reply.qno ;
        var qrcno = reply.qrcno ;

        $.ajax({
            type: "post" ,
            url: "/dutch/qnaReplies/" + qno + "/" + qrcno + "/new" + "/qna" ,
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


    function getCmtReply(qnoAndQrno, callback, error) {

        var qno = qnoAndQrno.qno ;
        var qrno = qnoAndQrno.qrno ;

        $.ajax({
            type: "get" ,
            url: "/dutch/qnaReplies/" + qno + "/" + qrno + "/qna" ,
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
        var qno = cmtReply.qno ;
        var qrno = cmtReply.qrno ;

        $.ajax({
            type: "put" ,
            url: "/dutch/qnaReplies/" + qno + "/" + qrno + "/qna" ,
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


    function removeCmtReply(qnaReplyCmt, callback, error) {

        var qno = qnaReplyCmt.qno ;
        var qrno = qnaReplyCmt.qrno ;

        $.ajax({
            type: "delete" ,
            url: "/dutch/qnaReplies/" + qno + "/" + qrno + "/qna" ,
            data: JSON.stringify(qnaReplyCmt) ,
            contentType: "application/json;charset=utf-8",
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

    } //removeCmtReply-end


    function removeAllReply(qno, callback, error) {
        
        $.ajax({
            type: "delete" ,
            url: "/dutch/qnaReplies/" + qno + "/qna" ,
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
        //console.log("myDate: " + myDate) ;

        var myDateTime = "" ;

        var yyyy = myDate.getFullYear() ;
        var mm = myDate.getMonth() + 1 ;  //1~12,  getMonth() is zero-based
        var dd = myDate.getDate() ;
        var hh = myDate.getHours() ;
        var mi = myDate.getMinutes() ;
        var ss = myDate.getSeconds() ;
        
        myDateTime =   [yyyy, "/",
                       (mm > 9 ? '' : "0") + mm , "/" ,
                       (dd > 9 ? '' : "0") + dd , " " ,
                       (hh > 9 ? '' : "0") + hh , ":" ,
                       (mi > 9 ? '' : "0") + mi , ":" ,
                       (ss > 9 ? '' : "0") + ss ].join('') ;
        return myDateTime                         

    } //myDateTimeFmt-end

    return {
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