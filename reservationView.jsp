<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*"%>
<%@ page import="net.rodjendani.models.*"%>
<%@ page import="net.rodjendani.dbServices.*"%>

<%
KorisnikDBS korisnikDBS = null;
String brTel = "";
Ponuda ponuda = (Ponuda) request.getAttribute("ponuda");
int ukupnaCena, osnovnaCena, ukupnoNegazirani, ukupnoGazirani, klovnCena, diskotekaCena, sportskeIgreCena,
		igraonicaCena;
float ukupnoPoena;
ukupnaCena = 0;
ukupnoPoena = 0;
osnovnaCena = 0;
ukupnoNegazirani = 0;
ukupnoGazirani = 0;
klovnCena = 0;
diskotekaCena = 0;
sportskeIgreCena = 0;
igraonicaCena = 0;
%>

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
							 korisnikDBS = (KorisnikDBS) session.getAttribute("korisnikDBS");
							%>
							<ul class="dropdown-menu dropdown-menu-end"
								aria-labelledby="navbarDropdownPortfolio">
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/KorisnikDashboard">Rezervacije</a></li>
								<li><a class="dropdown-item" href="${pageContext.request.contextPath}/Logout">Odjavi se</a></li>
								<li><font class="dropdown-item disabled">Poeni: <input class="form-control" style="width: 60px; display: inline;"
								type="text"
								value="<%=korisnikDBS.getBrojPoenaByUsername(session.getAttribute("user").toString())%>"
								readonly="readonly" id="poeni"></font></li>
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
		<header class="bg-primary py-5 text-white-50">
			<div class="container px-5  text-white-50">
				<%
		if (session.getAttribute("user") == null) {
		%>
		<div class="row text-white-50">
			<div class="col-md-1"></div>
			<div class="col-md-10 text-white">
				<p>
					<b>Registrujte se i sakupljajte poene za popust.</b>
				</p>
				<p>
					Prilikom svake rezervacije korisnik koji ima nalog sakuplja poene
					koje prilikom sledece rezervacije moze iskoristiti. <a
						href="/Rodjendani/Login">Registruj se</a>.
				</p>
			</div>
			<div class="col-md-1"></div>
		</div>
		<%
		}
		%>
		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-10">
				<h2>Rezervacija</h2>
				<table class="table text-white">
					<thead class="thead-light text-white">
						<tr>
							<th scope="col">Ime i prezime</th>
							<th scope="col">Kontakt telefon</th>
							<th scope="col">Negazirani sok</th>
							<th scope="col">Gazirani sok</th>
							<th scope="col">Klovn</th>
							<th scope="col">Diskoteka</th>
							<th scope="col">Sportske igre</th>
							<th scope="col">Igraonica</th>
						</tr>
					</thead>
					<%
					String klovn, diskoteka, sportskeIgre, igraonica;
					if (request.getParameter("klovn") != null)
						klovn = "Da";
					else
						klovn = "Ne";
					if (request.getParameter("diskoteka") != null)
						diskoteka = "Da";
					else
						diskoteka = "Ne";
					if (request.getParameter("sportskeIgre") != null)
						sportskeIgre = "Da";
					else
						sportskeIgre = "Ne";
					if (request.getParameter("igraonica") != null)
						igraonica = "Da";
					else
						igraonica = "Ne";
					%>
					<tbody>
						<tr>
							<td><%=request.getParameter("imeIPrezime")%></td>
							<td><%=request.getParameter("brTel")%></td>
							<td><%=request.getParameter("kolicinaNegaziranogSoka")%> L</td>
							<td><%=request.getParameter("kolicinaGaziranogSoka")%> L</td>
							<td><%=klovn%></td>
							<td><%=diskoteka%></td>
							<td><%=sportskeIgre%></td>
							<td><%=igraonica%></td>
						</tr>
					</tbody>
				</table>

			</div>
		</div>

		<div class="row">
			<div class="col-md-1"></div>
			<div class="col-md-4">
				<h2>Racun</h2>
				<table class="table text-white">
					<thead class="thead-light">
						<tr>
							<th scope="col">Stavka</th>
							<th scope="col">Kolicina</th>
							<th scope="col">Cena</th>
							<th scope="col">Ostvareni poeni</th>
							

						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Osnovni paket</td>
							<td>1</td>
							<%
							osnovnaCena = ponuda.getOsnovni();
							ukupnaCena += osnovnaCena;
							%>
							<td><%=ponuda.getOsnovni()%></td>
							<td>0</td>
						</tr>
						<tr>
							<td>Negazirani sok</td>
							<td><%=request.getParameter("kolicinaNegaziranogSoka")%> L</td>
							<%
							ukupnoNegazirani = Integer.parseInt(request.getParameter("kolicinaNegaziranogSoka").toString())
									* ponuda.getNegaziraniSok();
							ukupnaCena += ukupnoNegazirani;
							ukupnoPoena += Integer.parseInt(request.getParameter("kolicinaNegaziranogSoka").toString()) * 0.2;
							%>
							<td><%=ukupnoNegazirani%></td>
							<td><%=String.format("%.2f", Integer.parseInt(request.getParameter("kolicinaNegaziranogSoka").toString()) * 0.2)%></td>


						</tr>
						<tr>
							<td>Gazirani sok</td>
							<td><%=request.getParameter("kolicinaGaziranogSoka")%> L</td>
							<%
							ukupnoGazirani = Integer.parseInt(request.getParameter("kolicinaGaziranogSoka").toString()) * ponuda.getGaziraniSok();
							ukupnaCena += ukupnoGazirani;
							ukupnoPoena += Integer.parseInt(request.getParameter("kolicinaGaziranogSoka").toString()) * 0.2;
							%>
							<td><%=ukupnoGazirani%></td>
							<td><%=String.format("%.2f", Integer.parseInt(request.getParameter("kolicinaGaziranogSoka").toString()) * 0.2)%></td>
						</tr>
						<%
						if (request.getParameter("klovn") != null) {
						%>
						<tr>
							<td>Klovn</td>
							<td>1</td>
							<%
							klovnCena = ponuda.getKlovn();
							ukupnaCena += klovnCena;
							ukupnoPoena += 2;
							%>
							<td><%=klovnCena%></td>
							<td>2</td>

						</tr>
						<%
						}
						%>
						<%
						if (request.getParameter("diskoteka") != null) {
						%>
						<tr>
							<td>Diskoteka</td>
							<td>1</td>
							<%
							diskotekaCena = ponuda.getDiskoteka();
							ukupnaCena += diskotekaCena;
							ukupnoPoena += 3;
							%>
							<td><%=diskotekaCena%></td>
							<td>3</td>
						</tr>
						<%
						}
						%>
						<%
						if (request.getParameter("sportskeIgre") != null) {
						%>
						<tr>
							<td>Sportske igre</td>
							<td>1</td>
							<%
							sportskeIgreCena = ponuda.getSportskeIgre();
							ukupnaCena += sportskeIgreCena;
							ukupnoPoena += 2;
							%>
							<td><%=sportskeIgreCena%></td>
							<td>2</td>
						</tr>
						<%
						}
						%>
						<%
						if (request.getParameter("igraonica") != null) {
						%>
						<tr>
							<td>Igraonica</td>
							<td>1</td>
							<%
							igraonicaCena = ponuda.getIgraonica();
							ukupnaCena += igraonicaCena;
							ukupnoPoena += 2;
							%>
							<td><%=igraonicaCena%></td>
							<td>2</td>
						</tr>
						<%
						}
						%>
						<tr>
							<td><b>Ukupno</b></td>
							<td>==</td>
							<td id="ukupnaCena"><%=ukupnaCena%></td>
							<td><%=ukupnoPoena%></td>
						</tr>

					</tbody>
				</table>

			</div>
			<%if(session.getAttribute("user") != null && session.getAttribute("role").toString().matches("korisnik")) {%>
			<div class="col-md-1"></div>
			<div class="col-md-4">
				<h2>Ostvarite popust: </h2>
				<p class="text-white">Iskoristite poene da ostvarite popust</p>
				<div class="form-group row">
					<div class="col-sm-6">
						<input type="number" value="0" min="0" max="100" id="popust" class="form-control" placeholder="Unesite broj poena">
					</div>
					<div class="col-sm-6">
						<input type="submit" value="Izracunaj popust"
							class="btn btn-secondary" onclick="uracunajPopust()" id="btnPopust">
					</div>
				</div>
			</div>
			<div class="col-md-1"></div>
			<%} %>
		</div>


		<!-- Form Start -->
		<form method="post" action="ReservationConfirm">
		<div class="form-group row">
			<div class="col-sm-4"></div>
			<div class="col-sm-4">
				
				<%if(session.getAttribute("user") != null  && session.getAttribute("role").toString().matches("korisnik")){ %>
				<input type="hidden" name="poeniInput" id="poeniInput" value="<%=ukupnoPoena%>">
				<%} %>
				<input type="hidden" value="<%=request.getParameter("imeIPrezime") %>" name="username">
				<input type="hidden" value="<%=request.getParameter("brTel") %>" name="brTel">
				<input type="hidden" value="<%=request.getAttribute("agencijaID") %>" name="agencijaID">
				<input type="hidden" value="<%=request.getParameter("datum") + " " + request.getParameter("vreme")%>" name="vremeRodjendana">
				<input type="hidden" value="<%=request.getParameter("kolicinaNegaziranogSoka") %>" name="kolicinaNegaziranogSoka">
				<input type="hidden" value="<%=request.getParameter("kolicinaGaziranogSoka") %>" name="kolicinaGaziranogSoka">
				
				<%if(request.getParameter("klovn") != null ) {%>
				<input type="hidden" value="1" name="klovn">
				<%} else {%>
				<input type="hidden" value="0" name="klovn">
				<%} %>
				<%if(request.getParameter("diskoteka") != null ) {%>
				<input type="hidden" value="1" name="diskoteka">
				<%} else {%>
				<input type="hidden" value="0" name="diskoteka">
				<%} %>
				<%if(request.getParameter("sportskeIgre") != null ) {%>
				<input type="hidden" value="1" name="sportskeIgre">
				<%} else {%>
				<input type="hidden" value="0" name="sportskeIgre">
				<%} %>
				<%if(request.getParameter("igraonica") != null ) {%>
				<input type="hidden" value="1" name="igraonica">
				<%} else {%>
				<input type="hidden" value="0" name="igraonica">
				<%} %>
				
		
				
				
				<input type="submit" class="form-control btn btn-secondary"
					value="Potvrdi" )>

			</div>
			<div class="col-sm-4"></div>
		</div>
		</form>
		<!-- Form END -->
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

    <%
	if (session.getAttribute("user") != null && session.getAttribute("role").toString().matches("korisnik")) {
	%>
	<script type="text/javascript">
		function uracunajPopust() {
			var ukupnaCena = parseInt(document.getElementById("ukupnaCena").innerHTML
					.toString());
			var poeni = parseInt(document.getElementById("poeni").value
					.toString())
			var popust = parseInt(document.getElementById("popust").value
					.toString())
					
			if(popust <= <%=korisnikDBS.getBrojPoenaByUsername(session.getAttribute("user").toString())%> && popust > 0)
				{
					document.getElementById("ukupnaCena").innerHTML = ukupnaCena - ((popust/100) * ukupnaCena);
					if((ukupnaCena - ((popust/100) * ukupnaCena)) < 0 )
						{
						document.getElementById("ukupnaCena").innerHTML = 0;
						}
					document.getElementById("btnPopust").disabled = true;
					document.getElementById("popust").disabled = true;
					document.getElementById("poeni").value = poeni - popust;
					document.getElementById("poeniInput").value = parseInt(<%=korisnikDBS.getBrojPoenaByUsername(session.getAttribute("user").toString())%> - popust + <%=ukupnoPoena%>);
				}
			else
				{
					document.getElementById("popust").value = "Mozete koristiti <%=korisnikDBS.getBrojPoenaByUsername(session.getAttribute("user").toString())%> poena";
				}
			
		}
	</script>
	<%
	}
	%>
</body>
</html>
