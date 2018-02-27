<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<div id="page-container" class="header-fixed-top">
   <!-- Main Container -->
   <div id="main-container">
      <header class="navbar navbar-inverse navbar-fixed-top" role="navigation">
         <div class="container">
            <!-- GNB-HEADER -->
            <div class="navbar-header">
               <a href="">
                  <h1 class="navbar-brand hidden-lg" style="padding-top: 5px, padding-bottom: 5px;"><img src="./개발자 가이드_files/hexacode.png" alt="hexacode" width="69" height="50"></h1>
                  <h1 class="navbar-brand visible-lg"><img src="./개발자 가이드_files/hexacode-lg.png" alt="hexacode" width="186" height="30"></h1>
               </a>
            </div>
            <!-- GNB -->
            <div class="collapse navbar-collapse" id="horizontal-menu-collapse">
               <ul class="nav navbar-nav">
                  <li class="dropdown">
                     <a href="" class=" dropdown-toggle disabled " data-toggle="dropdown">조회</a>
                     <ul class="dropdown-menu">
                           <li class="">
                              <a href="">계좌조회</a>
                           </li>
                           <li class="">
                              <a href="">예금/신탁</a>
                           </li>
                           <li class="divider"></li>
                           <li class="">
                              <a href="">대출</a>
                           </li>
                           <li class="">
                              <a href="">펀드</a>
                           </li>
                           <li class="">
                              <a href="">외환</a>
                           </li>
                           <li class="divider"></li>
                           <li class="">
                              <a href="">휴면예금조회</a>
                           </li>
                           <li class="">
                              <a href="">수표조회</a>
                           </li>
                        </ul>
                     </li>
                     <li class="dropdown">
                        <a href="" class=" dropdown-toggle disabled " data-toggle="dropdown">이체</a>
                        <ul class="dropdown-menu">
                              <li class="">
                                 <a href="">당행/타행이체</a>
                              </li>
                              <li class="">
                                 <a href="">다계좌이체</a>
                              </li>
                              <li class="">
                                 <a href="">이체결과조회</a>
                              </li>
                              <li class="divider"></li>
                              <li class="">
                                 <a href="">예약이체</a>
                              </li>
                              <li class="">
                                 <a href="">지연이체</a>
                              </li>
                              <li class="">
                                 <a href="">자동이체</a>
                              </li>
                              <li class="">
                                 <a href="">급여이체</a>
                              </li>
                              <li class="divider"></li>
                              <li class="">
                                 <a href="">계좌이동</a>
                              </li>
                              <li class="">
                                 <a href="">기타이체 서비스</a>
                              </li>
                           </ul>
                        </li>
                        <li class="dropdown">
                           <a href="" class=" dropdown-toggle disabled " data-toggle="dropdown">금융상품</a>
                           <ul class="dropdown-menu">
                                 <li class="">
                                    <a href="">예금/신탁</a>
                                 </li>
                                 <li class="">
                                    <a href="">대출</a>
                                 </li>
                                 <li class="">
                                    <a href="">펀드</a>
                                 </li>
                                 <li class="">
                                    <a href="">외환</a>
                                 </li>
                                 <li class="">
                                    <a href="">퇴직연금</a>
                                 </li>
                                 <li class="">
                                    <a href="">보험/공제</a>
                                 </li>
                                 <li class="">
                                    <a href="">골드/실버</a>
                                 </li>
                              </ul>
                           </li>
                           <li class="dropdown">
                              <a href="" class=" dropdown-toggle disabled " data-toggle="dropdown">공과금/법원</a>
                              <ul class="dropdown-menu">
                                    <li class="">
                                       <a href="">지로납부</a>
                                    </li>
                                    <li class="">
                                       <a href="">지방세</a>
                                    </li>
                                    <li class="">
                                       <a href="">세외수입</a>
                                    </li>
                                    <li class="">
                                       <a href="">관리비</a>
                                    </li>
                                    <li class="divider"></li>
                                    <li class="">
                                       <a href="">법원</a>
                                    </li>
                                    <li class="">
                                       <a href="">국세</a>
                                    </li>
                                    <li class="">
                                       <a href="">관세</a>
                                    </li>
                                    <li class="">
                                       <a href="">사회보험료</a>
                                    </li>
                                    <li class="divider"></li>
                                    <li class="">
                                       <a href="">범칙금/기타</a>
                                    </li>
                                 </ul>
                              </li>
                              <li class="dropdown">
                                 <a href="" class=" dropdown-toggle disabled " data-toggle="dropdown">부가서비스</a>
                                 <ul class="dropdown-menu">
                                       <li class="">
                                          <a href="">증명서발급</a>
                                       </li>
                                       <li class="">
                                          <a href="">소득공제</a>
                                       </li>
                                       <li class="">
                                          <a href="">전자어음</a>
                                       </li>
                                    </ul>
                                 </li>
                                 <li class="dropdown">
                                    <a href="" class=" dropdown-toggle disabled " data-toggle="dropdown">사용자관리</a>
                                    <ul class="dropdown-menu">
                                          <li class="">
                                             <a href="">고객정보관리</a>
                                          </li>
                                          <li class="">
                                             <a href="">인터넷뱅킹관리</a>
                                          </li>
                                          <li class="">
                                             <a href="">계좌관리</a>
                                          </li>
                                          <li class="">
                                             <a href="">사고신고</a>
                                          </li>
                                       </ul>
                                    </li>
                                 </ul>
               <div class="navbar-right">
                  <ul class="nav navbar-nav member-menu">

                     <!-- User Dropdown -->
                                                               <li class="dropdown">
                        <a data-toggle="dropdown" class="dropdown-toggle disabled" href="">
                                                      <block href=""><i class="fa fa-user" style="margin-right:8px"></i>로그인                        </block></a>
                        <ul id="member-menu-container" class="dropdown-menu">
                           <li>
                                                                                                                                                      <a href="LoginForm.jsp">로그인/로그아웃</a>                              <a href="AgreementForm.jsp">회원가입</a>                           </li>
                        </ul>
                     </li>
                     <!-- END User Dropdown -->
                  </ul>
               </div>
            </div>
         </div>
      </header>