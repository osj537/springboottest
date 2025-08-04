<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<section id="content">
    <h2>HelloSpring</h2>
    <%--<% String name=null;%>
    <p><%=name.length()%></p>--%>
    <h2>ajax요청하기</h2>
    <button onclick="basicAjax()">basicAjax</button>
    <button onclick="getMembers()">게시글 조회</button>
    <button onclick="getMember()">회원 조회</button>
    <div id="result"></div>
    <button onclick="insertMember()">회원가입</button>
    <button onclick="restTest();">테스트</button>
    <script>
        const restTest=async ()=>{
            const member={
                userId:"user"+Math.floor(Math.random()*100+10),
                password:"1234",
                userName:"user"+Math.floor(Math.random()*100+10),
                gender:"M",
                age:23,
                phone:"0101234",
                email:"test@test.com",
                address:"서울시 금천구",
                hobby:["운동","독서"]
            }
            const response=await fetch("${pageContext.request.contextPath}/member",
                {
                    method:"post",
                    headers:{
                        "Content-Type":"application/json;charset=utf-8",
                    },body:JSON.stringify(member)
                });
            console.log(response);
            //if(response.ok){ const data=await response.json();}
        }
        const insertMember=async ()=>{
            const member={
                userId:"user"+Math.floor(Math.random()*100+10),
                password:"1234",
                userName:"user"+Math.floor(Math.random()*100+10),
                gender:"M",
                age:23,
                phone:"0101234",
                email:"test@test.com",
                address:"서울시 금천구",
                hobby:["운동","독서"]
            }
            const response=await fetch("${pageContext.request.contextPath}/ajax/insertmember",
                {
                    method:"post",
                    headers:{
                        "${_csrf.headerName}":"${_csrf.token}",
                        "Content-Type":"application/json;charset=utf-8",
                    },body:JSON.stringify(member)
            });
            const data=await response.json();
            console.log(data);
        }
        const getMember=async()=>{
            loading("result");
            const response=await fetch("${pageContext.request.contextPath}/ajax/member?userId=admin");
            const data=await response.text();
            document.getElementById("result").innerHTML=data;
        }
        const basicAjax=async ()=>{
            const response=await fetch("${pageContext.request.contextPath}/ajax/basic");
            if(response.ok) {
                const data = await response.json();
                console.log(data);
            }else{
                alert("요청실패!");
            }
        }
        const getMembers=async ()=>{
            loading("result");
            const response=await fetch("${pageContext.request.contextPath}/ajax/board");
            if(response.ok) {
                const data = await response.json();//text()
                console.log(data);
                document.getElementById("result").innerHTML="";
                const $table=document.createElement("table");
                const $header=
                    ["번호","제목","작성자","작성일"].reduce((init,next)=>{
                    const $th=document.createElement("th");
                    $th.innerText=next;
                    init.appendChild($th);
                    return init;
                },document.createElement("tr"));
                $table.appendChild($header);
                data.forEach(b=>{
                    const $tr=Object.values(b).reduce((init,next)=>{
                        const $td=document.createElement("td")
                        $td.innerText=next;
                        init.appendChild($td);
                        return init;
                    },document.createElement("tr"));
                    $table.appendChild($tr);
                });
                document.getElementById("result").append($table);
            }else{

            }
        }
        const loading=(id)=>{
            document.getElementById(id)
                .innerHTML=`
                    <div class='spinner-border text-danger' role='status'>
                        <span class='visually-hidden'></span>
                    </div>
                `;
        }
    </script>

    <input id="userId"><button onclick="searchId();">조회</button>
    <script>
        function searchId(){
            const userId=document.querySelector("#userId").value;
            fetch("${pageContext.request.contextPath}/jpa/member/"+userId)
                .then(response=>response.json())
                .then(data=>{
                    console.log(data);
                });
        }
        </script>


</section>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
