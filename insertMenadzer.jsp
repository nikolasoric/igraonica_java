<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="net.rodjendani.models.*"%>
<%@ page import="net.rodjendani.dbServices.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>HappyBirthday</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon"
	href="${pageContext.request.contextPath}/webresources/assets/favicon.ico" />
<!-- Bootstrap icons-->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css"
	rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link
	href="${pageContext.request.contextPath}/webresources/css/styles.css"
	rel="stylesheet" />

<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.6.1/css/all.css"
	integrity="sha384-gfdkjb5BdAXd+lj+gudLWI+BXq4IuLW5IT+brZEZsLFm++aCMlF1V92rMkPaX4PP"
	crossorigin="anonymous">
	
	
	
	
</head>
<body class="d-flex flex-column h-100 bg-primary">
	<main class="flex-shrink-0">
		<!-- Navigation-->
		<nav class="navbar navbar-expand-lg bg-secondary text-uppercase">
			<div class="container px-5">
				<a class="navbar-brand"
					href="${pageContext.request.contextPath}/Home">Proslavi rodjendan</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav ms-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/Home">Pocetna</a></li>
						<%
				if (session.getAttribute("user") == null) {
				%>
				<li class="nav-item"><a class="nav-link"
							href="${pageContext.request.contextPath}/Login">Prijavi se</a></li>
				<%
				}
				%>
				<%
				if (session.getAttribute("user") != null) {
				%>
						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle" id="navbarDropdownPortfolio"
							href="#" role="button" data-bs-toggle="dropdown"
							aria-expanded="false"><%=session.getAttribute("user").toString() %></a>
							<%if(session.getAttribute("role").toString().matches("korisnik")) {%>
                            <%
							KorisnikDBS korisnikDBS = (KorisnikDBS) session.getAttribute("korisnikDBS");
							%>
							
							<ul class="dropdown-menu dropdown-menu-end"
								aria-labelledby="navbarDropdownPortfolio">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/KorisnikDashboard">Rezervacije</a></li>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/Logout">Odjavi se</a></li>
                                <li><font class="dropdown-item disabled">Poeni: <input class="form-control" style="width: 60px; display: inline;"
								type="text"
								value="<%=korisnikDBS.getBrojPoenaByUsername(session.getAttribute("user").toString())%>"
								readonly="readonly"></font></li>
							</ul>
						
				
							<%} %>
							<%if(session.getAttribute("role").toString().matches("menadzer")) {%>
							<ul class="dropdown-menu dropdown-menu-end"
								aria-labelledby="navbarDropdownPortfolio">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/HomeMenadzer">Rezervacije</a></li>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/Logout">Odjavi se</a></li>
							</ul>
							<%} %>
							<%if(session.getAttribute("role").toString().matches("admin")) {%>
							<ul class="dropdown-menu dropdown-menu-end"
								aria-labelledby="navbarDropdownPortfolio">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/HomeAdmin">Administracija</a></li>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/Logout">Odjavi se</a></li>
							</ul>
							<%} %>
						</li>
						
				<%
				}
				%>
					</ul>
				</div>
			</div>
		</nav>
		<!-- Header-->
		<header class="bg-primary py-5 text-white">
			<div class="container px-5">
			<form id="registracija" method="post" action="InsertMenadzer">
			<div class="form-group row py-1">
				<div class="col-sm-2"></div>
				<label for="colFormLabel" class="col-sm-2 col-form-label">Username</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="colFormLabel"
						name="username">
				</div>
				<div class="col-sm-2"></div>
			</div>
			<div class="form-group row py-1">
				<div class="col-sm-2"></div>
				<label for="colFormLabel" class="col-sm-2 col-form-label">Ime
					i Prezime</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="colFormLabel"
						name="imePrezime">
				</div>
				<div class="col-sm-2"></div>
			</div>
			<div class="form-group row py-1">
				<div class="col-sm-2"></div>
				<label for="colFormLabel" class="col-sm-2 col-form-label">Kontakt
					telefon</label>
				<div class="col-sm-6">
					<input type="text" class="form-control" id="colFormLabel"
						name="brTel">
				</div>
				<div class="col-sm-2"></div>
			</div>
			<%List<Agencija> agencije = (List<Agencija>) request.getAttribute("agencije"); %>
			<div class="form-group row py-1">
				<div class="col-sm-2"></div>
				<label for="colFormLabel" class="col-sm-2 col-form-label">Agencija</label>
				<div class="col-sm-6">
					<select class="form-control" id="colFormLabel" name="agencijaID">
						<option selected value="none">Odaberite agenciju</option>
						<%if(agencije != null){ %>
						<%for(Agencija agencija : agencije){ %>
						<option value="<%=agencija.getAgencijaID()%>"><%=agencija.getAgencijaID()%> - <%=agencija.getNaziv()%></option>
						<%} %>
						<%} %>
					</select>
				</div>
				<div class="col-sm-2"></div>
			</div>

			<div class="form-group row py-1">
				<div class="col-sm-2"></div>
				<label for="colFormLabel" class="col-sm-2 col-form-label">Password</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="colFormLabel"
						name="pass">
				</div>
				<div class="col-sm-2"></div>
			</div>
			<div class="form-group row py-1">
				<div class="col-sm-2"></div>
				<label for="colFormLabel" class="col-sm-2 col-form-label">Potvrdite
					sifru</label>
				<div class="col-sm-6">
					<input type="password" class="form-control" id="colFormLabel"
						name="passConf">
				</div>
				<div class="col-sm-2"></div>
			</div>
			<%
			if (request.getAttribute("message") != null) {
			%>
			<div class="row">
				<div class="col-sm-2"></div>
				<div class="col-sm-8" align="center">
					<p style="color: red"><%=request.getAttribute("message")%></p>
				</div>
				<div class="col-sm-2"></div>
			</div>
			<%
			}
			%>
			<div class="form-group row py-1">
				<div class="col-sm-2"></div>
				<div class="col-sm-8">
					<input type="submit" class="form-control btn btn-secondary"
						id="colFormLabel" value="Unesi">
				</div>
				<div class="col-sm-2"></div>
			</div>
		</form>
			</div>
		</header>
		
	</main>
	<!-- Footer-->
	<footer class="bg-secondary py-4 mt-auto">
		<div class="container px-5">
			<div
				class="row align-items-center justify-content-between flex-column flex-sm-row">
				<div class="col-auto">
					<div class="small m-0 text-white">Copyright &copy; Nikola Soric 2021</div>
				</div>
				
			</div>
		</div>
	</footer>
	<!-- Bootstrap core JS-->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.bundle.min.js"></script>
	<!-- Core theme JS-->
	<script
		src="${pageContext.request.contextPath}/webresources/js/scripts.js"></script>
</body>
</html>
