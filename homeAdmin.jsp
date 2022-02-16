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
<title>Proslavi rodjendan</title>
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
			<h2>Agencije</h2>
			<form method="get" action="InsertAgencija">
				<input type="submit" value="Unesi novu agenciju"
					class="btn btn-secondary">
			</form>
			<table class="table text-white">
				<thead class="thead-light">
					<tr>
						<th scope="col">ID</th>
						<th scope="col">Naziv</th>
						<th scope="col">Adresa</th>
						<th scope="col">Telefon</th>
						<th scope="col">Url slike</th>
						<th scope="col">Akcije</th>
					</tr>
				</thead>
				<%
				List<Agencija> agencije = (List<Agencija>) request.getAttribute("agencije");
				%>
				<tbody>
					<%
					if (agencije != null) {
					%>
					<%
					for (Agencija agencija : agencije) {
					%>
					<tr>
						<th scope="row"><%=agencija.getAgencijaID()%></th>
						<td><%=agencija.getNaziv()%></td>
						<td><%=agencija.getAdresa()%></td>
						<td><%=agencija.getTelefon()%></td>
						<td><%=agencija.getImgUrl()%></td>
						<td class="row ">
							<form method="post" action="DeleteAgencija" class="py-1">
								<input type="hidden" value="<%=agencija.getAgencijaID()%>" name="agencijaID">
								<input type="submit" value="Obrisi" class="btn btn-danger">
							</form>
							<div class="col-md-1"></div>
							<form method="get" action="EditAgencija">
								<input type="hidden" value="<%=agencija.getAgencijaID()%>" name="agencijaID">
								<input type="submit" value="Izmeni" class="btn btn-secondary">
							</form>
						</td>
					</tr>
					<%
					}
					%>
					<%
					}
					%>
				</tbody>
			</table>
			<div class="py-5"></div>
		
		
		<div class="container" id="korisnici">


			<h2 id="menadzeri">Menadzeri</h2>
			<form action="InsertMenadzer" method="get" class="py-1">
				<input type="submit" value="Unesi novog menadzera"
					class="btn btn-secondary">
			</form>
			<table class="table text-white">
				<thead class="thead-light">
					<tr>
						<th scope="col">Username</th>
						<th scope="col">Ime i prezime</th>
						<th scope="col">Agencija</th>
						<th scope="col">Broj telefona</th>
						<th scope="col">Akcije</th>
					</tr>
				</thead>
				<%
				List<Menadzer> menadzeri = (List<Menadzer>) request.getAttribute("menadzeri");
				%>
				<%
				if (menadzeri != null) {
				%>
				<tbody>
					<%
					for (Menadzer menadzer : menadzeri) {
					%>
					<tr>
						<td><%=menadzer.getUsername()%></td>
						<td><%=menadzer.getImePrezime()%></td>
						<td><%=menadzer.getAgencijaID()%></td>
						<td><%=menadzer.getBrTel()%></td>
						<td class="row">
							<form method="post" action="DeleteMenadzer" class="py-1">
								<input type="hidden" value="<%=menadzer.getUsername()%>" name="username">
								<input type="submit" value="Obrisi" class="btn btn-danger">
							</form>
							<div class="col-md-1"></div>
							<form method="get" action="EditMenadzer">
								<input type="hidden" value="<%=menadzer.getUsername()%>" name="username">
								<input type="submit" value="Izmeni" class="btn btn-secondary" >
							</form>
						</td>
					</tr>
					<%
					}
					%>
				</tbody>
				<%
				}
				%>
			</table>
			
			<div class="py-5"></div>
			<h2 >Korisnici</h2>
			<table class="table text-white">
				<thead class="thead-light">
					<tr>
						<th scope="col">Username</th>
						<th scope="col">Ime i prezime</th>
						<th scope="col">Poeni</th>
						<th scope="col">Broj telefona</th>
						<th scope="col">Akcije</th>
					</tr>
				</thead>
				<%
				List<Korisnik> korisnici = (List<Korisnik>) request.getAttribute("korisnici");
				%>
				<%
				if (korisnici != null) {
				%>
				<tbody>

					<%
					for (Korisnik korisnik : korisnici) {
					%>
					<tr>
						<td><%=korisnik.getUsername()%></td>
						<td><%=korisnik.getImePrezime()%></td>
						<td><%=korisnik.getPoeni()%></td>
						<td><%=korisnik.getBrTel()%></td>

						<td class="row">
							<form method="post" action="DeleteKorisnik" class="py-1">
								<input type="hidden" value="<%=korisnik.getUsername()%>" name="username">
								<input type="submit" value="Obrisi" class="btn btn-danger">
							</form>
							<div class="col-md-1"></div>
							<form method="get" action="EditKorisnik">
								<input type="hidden" value="<%=korisnik.getUsername()%>" name="username">
								<input type="submit" value="Izmeni" class="btn btn-secondary">
							</form>
						</td>
					</tr>
					<%
					}
					%>

				</tbody>
				<%
				}
				%>
			</table>
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
