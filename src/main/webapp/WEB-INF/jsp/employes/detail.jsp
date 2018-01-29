<%@ page import="com.ipiecoles.java.java320.model.Employe" %>
<%@ page import="com.ipiecoles.java.java320.model.Commercial" %>
<%@ page import="com.ipiecoles.java.java320.model.Technicien" %>
<%@ page import="com.ipiecoles.java.java320.model.Manager" %>
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

<%! Employe employe; %>
<% employe = (Employe) pageContext.findAttribute("model");%>
<div class="container">
    <h2>Détail du ${model.className} ${model.matricule}</h2>
    <form action="/<%= employe.getClassName().toLowerCase() + "s"%>/<%= employe.getId() == null ? "save" : employe.getId() %>" method="post">
    <div class="row">
        <div class="col-lg-6">
            <div class="form-group">
                <label class="form-control-label" for="nom">Nom</label>
                <input type="text" value="${model.nom}" class="form-control" name="nom" id="nom">

                <label class="form-control-label" for="prenom">Prénom</label>
                <input type="text" value="${model.prenom}" class="form-control" name="prenom" id="prenom">

                <label class="form-control-label" for="matricule">Matricule</label>
                <input type="text" value="${model.matricule}" class="form-control" name="matricule" id="matricule">
            </div>
        </div>
        <div class="col-lg-6">
            <div class="form-group">
                <label class="form-control-label" for="nom">Salaire</label>
                <div class="input-group">
                    <input type="number" value="${model.salaire}" class="form-control" name="salaire" id="salaire">
                    <span class="input-group-addon">€</span>
                </div>

                <c:if test="!isNew">

                <label class="form-control-label" for="nom">Prime Annuelle</label>
                <div class="input-group">
                    <input type="text" value="${model.primeAnnuelle}" class="form-control" name="primeAnnuelle" id="primeAnnuelle">
                    <span class="input-group-addon">€</span>
                </div>

                </c:if>

                <label class="form-control-label" for="nom">Date d'embauche</label>
                <input type="text" value="${model.dateEmbauche.toString("dd/MM/YYYY")}" class="form-control" name="dateEmbauche" id="dateEmbauche">

                <% if (employe instanceof Commercial) { %>
                <label class="form-control-label" for="performance">Performance</label>
                <input type="number" value="${model.performance}" class="form-control" name="performance" id="performance">

                <label class="form-control-label" for="caAnnuel">CA Annuel</label>
                <div class="input-group">
                    <input type="number" value="${model.caAnnuel}" class="form-control" name="caAnnuel" id="caAnnuel">
                    <span class="input-group-addon">€</span>
                </div>
                <% } %>

                <% if (employe instanceof Technicien) { %>
                <label class="form-control-label" for="grade">Grade</label>
                <input type="number" value="${model.grade}" class="form-control" name="grade" id="grade">

                <label class="form-control-label">Manager</label>
                <ul class="list-group">
                    <li class="list-group-item">
                        <a href="/employes/${model.manager.id}">${model.manager.prenom} ${model.manager.nom}
                            <span class="badge pull-right">${model.manager.matricule}</span></a>
                    </li>
                </ul>
                <% } %>

                <% if (employe instanceof Manager) { %>
                <label class="form-control-label" for="performance">Equipe</label>
                <div class="row">
                    <div class="col-lg-10">
                        <ul class="list-group">
                            <c:forEach items="${model.equipe}" var="tech">
                                <li class="list-group-item"><a href="employes/${tech.id}">${tech.prenom} ${tech.nom} <span class="badge pull-right">${tech.matricule}</span></a></li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="col-lg-2 text-center">
                        <div class="list-group text-center">
                            <c:forEach items="${model.equipe}" var="tech">
                                <li class="list-group-item"><a href="/managers/${model.id}/techniciens/${tech.id}/delete"><span class="glyphicon glyphicon-remove"></span></a></li>
                            </c:forEach>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-lg-10">
                        <%--{{input type="text" value=matriculeToAdd placeholder="Ajouter un technicien avec le matricule..." class="form-control"}}--%>
                    </div>
                    <div class="col-lg-2 text-center">
                        <%--<button {{action "addTechniciens" matriculeToAdd}} class="btn-success list-group-item list-group-item-action"><span class="glyphicon glyphicon-plus"></span></button>--%>

                    </div>
                </div>
                <% } %>
            </div>
        </div>
    </div>

    <div class="row">
        <button class="btn btn-primary">Enregistrer</button>
    </div>
    </form>
    <div class="row">
        <c:if test="${!empty model.id}">
            <a href="/employes/${model.id}/delete" class="btn btn-danger">Supprimer</a>
        </c:if>
    </div>
</div>

<script type="text/javascript" src="/webjars/bootstrap/3.3.7/js/bootstrap.min.js"></script>

</body>

</html>