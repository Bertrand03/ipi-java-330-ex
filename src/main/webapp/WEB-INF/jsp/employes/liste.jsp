<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html lang="en" >
<head>

    <!-- Access the bootstrap Css like this,
        Spring boot will handle the resource mapping automcatically -->
    <link rel="stylesheet" type="text/css" href="/webjars/bootstrap/3.3.7/css/bootstrap.min.css" />

    <!--
	<spring:url value="/css/main.css" var="springCss" />
	<link href="${springCss}" rel="stylesheet" />
	 -->
    <c:url value="/css/main.css" var="jstlCss" />
    <link href="${jstlCss}" rel="stylesheet" />
    <%@ page contentType="text/html; charset=UTF-8" %>

</head>
<body>
<%@ include file="../tags/navbar.jsp"%>


<div class="container">


    <div class="row">
        <div class="col-lg-12">
            <h1>Liste des employés</h1>
            <div class="btn-group">
                <a href="#" class="btn btn-primary dropdown-toggle" data-toggle="dropdown" aria-expanded="false">
                    Nouvel employé
                    <span class="caret"></span>
                </a>
                <ul class="dropdown-menu">
                    <li><a href="/employes/new/technicien">Technicien</a></li>
                    <li><a href="/employes/new/commercial">Commercial</a></li>
                    <li><a href="/employes/new/manager">Manager</a></li>
                </ul>
            </div>
            <table class="table table-hover table-striped">
                <thead>
                <tr>
                    <th scope="col">
                        <c:choose>
                        <c:when test="${sortProperty.equals('matricule')}">
                            <c:choose>
                            <c:when test="${sortDirection.equals('DESC')}">
                                Matricule <a href="/employes?page=${page}&size=${size}&sortDirection=ASC&sortProperty=matricule"><span class="glyphicon glyphicon-chevron-up"></span></a>
                            </c:when>
                            <c:otherwise>
                                Matricule <a href="/employes?page=${page}&size=${size}&sortDirection=DESC&sortProperty=matricule"><span class="glyphicon glyphicon-chevron-down"></span></a>
                            </c:otherwise>
                            </c:choose>
                        </c:when>
                            <c:otherwise>
                                <a href="/employes?page=${page}&size=${size}&sortDirection=ASC&sortProperty=matricule">Matricule</a>
                            </c:otherwise>
                        </c:choose>
                    </th>
                    <th scope="col">
                        <c:choose>
                        <c:when test="${sortProperty.equals('nom')}">
                            <c:choose>
                                <c:when test="${sortDirection.equals('DESC')}">
                                    Nom <a href="/employes?page=${page}&size=${size}&sortDirection=ASC&sortProperty=nom"><span class="glyphicon glyphicon-chevron-up"></span></a>
                                </c:when>
                                <c:otherwise>
                                    Nom <a href="/employes?page=${page}&size=${size}&sortDirection=DESC&sortProperty=nom"><span class="glyphicon glyphicon-chevron-down"></span></a>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <a href="/employes?page=${page}&size=${size}&sortDirection=ASC&sortProperty=nom">Nom</a>
                        </c:otherwise>
                        </c:choose>
                    </th>
                    <th scope="col">
                        <c:choose>
                        <c:when test="${sortProperty.equals('prenom')}">
                            <c:choose>
                                <c:when test="${sortDirection.equals('DESC')}">
                                    Prénom <a href="/employes?page=${page}&size=${size}&sortDirection=ASC&sortProperty=prenom"><span class="glyphicon glyphicon-chevron-up"></span></a>
                                </c:when>
                                <c:otherwise>
                                    Prénom <a href="/employes?page=${page}&size=${size}&sortDirection=DESC&sortProperty=prenom"><span class="glyphicon glyphicon-chevron-down"></span></a>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <a href="/employes?page=${page}&size=${size}&sortDirection=ASC&sortProperty=prenom">Prénom</a>
                        </c:otherwise>
                        </c:choose>
                    </th>
                    <th scope="col"></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach items="${model.getContent()}" var="employe">
                    <tr>
                        <th scope="row">${employe.matricule}</th>
                        <td>${employe.nom}</td>
                        <td>${employe.prenom}</td>
                        <td><a href="/employes/${employe.id}">Détail</a></td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <div class="row">
                <div class="col-lg-6">
                    <p>
                        Affichage des employés ${start} à ${end} sur un total de ${model.totalElements}</p>
                </div>
                <div class="col-lg-6">
                    <ul class="pagination">
                        <c:choose>
                            <c:when test="model.getNumber.equals(0)">
                                <li class= "disabled">&laquo;</li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="/employes?page=${page-1}&size=${size}&sortDirection=${sortDirection}&sortProperty=${sortProperty}">&laquo;</a></li>
                            </c:otherwise>
                        </c:choose>
                        </li>
                        <li><a href="#">Page ${page+1}</a></li>

                        <c:choose>
                            <c:when test="model.totalPages==pageAffichage">
                                <li class= "disabled">&raquo;</li>
                            </c:when>
                            <c:otherwise>
                                <li><a href="/employes?page=${page+1}&size=${size}&sortDirection=${sortDirection}&sortProperty=${sortProperty}">&raquo;</a></li>
                            </c:otherwise>
                        </c:choose>

                        </li>
                    </ul></div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="webjars/jquery/3.3.1/jquery.js"></script>
<script type="text/javascript" src="webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>

</html>