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
</head>
<body class="d-flex flex-column h-100">
	<main class="flex-shrink-0">
		<!-- Navigation-->
		<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top">
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
		<header class="bg-primary py-5">
			<div class="container px-5">
				<div class="row gx-5 align-items-center justify-content-center">
					<div class="col-lg-8 col-xl-7 col-xxl-6">
						<div class="my-5 text-center text-xl-start">
							<h1 class="display-5 fw-bolder text-white mb-2">O nama</h1>
							<p class="lead fw-normal text-white mb-4">Proslavi rodjendan
								Vam nudi brz i lak nacin rezervacije proslava rodjendana.
								Rezervisite termin u nekoj od nasih agencija, brzo i lako. Uz
								skupljanje poena ostvarite super popuste.</p>
							<div
								class="d-grid gap-3 d-sm-flex justify-content-sm-center justify-content-xl-start">
								<a class="btn btn-secondary btn-lg px-4 me-sm-3" href="#agencije">Krenimo</a>
							</div>
						</div>
					</div>
					<div class="col-xl-5 col-xxl-6 d-none d-xl-block text-center">
						<img class="img-fluid rounded-3 my-5"
							src="${pageContext.request.contextPath}/webresources/assets/images/banner.jpg"
							alt="..." />
					</div>
				</div>
			</div>
		</header>
		<!-- Blog preview section-->
		<section class="py-5" id="agencije">
			<div class="container px-5 my-5">
				<!-- Portfolio Section Heading-->
                <h2 class="page-section-heading text-center text-uppercase text-secondary mb-0">Nasa ponuda</h2>
                <!-- Icon Divider-->
                <div class="divider-custom">
                    <div class="divider-custom-line"></div>
                    <div class="divider-custom-icon"><i class="fas fa-user"></i></div>
                    <div class="divider-custom-line"></div>
                </div>
				<div class="row gx-5">
				<%
				List<Agencija> agencije = (List<Agencija>) request.getAttribute("agencije");
				%>

				<%
				for (Agencija agencija : agencije) {
				%>
					<div class="col-lg-4 mb-5 ">
						<div class="card h-100 shadow border-0 bg-secondary">
							<img class="card-img-top"
								src="${pageContext.request.contextPath}/webresources/assets/img/portfolio/<%=agencija.getImgUrl()%>" alt="..." />
							<div class="card-body p-4">
								<h5 class="card-title mb-3 text-white-50"><%=agencija.getNaziv()%></h5></a>
									<%
								PonudaDBS ponudaService = new PonudaDBS();
								ponudaService.connect();
								Ponuda ponuda = ponudaService.getByAgencija(agencija);
								%>
								
								<ul class="list-inline card-text text-white-50 mb-0">
									<li><b>CENOVNIK Ponude</b></li>
									<li>Osnovni paket: <%=ponuda.getOsnovni()%>rsd
									</li>
									<li>Gazirani sokovi: <%=ponuda.getGaziraniSok()%>rsd/l
									</li>
									<li>Negazirani sokovi: <%=ponuda.getNegaziraniSok()%>rsd/l
									</li>
									<li>Klovn: <%=ponuda.getKlovn()%>rsd
									</li>
									<li>Diskoteka sa karaokama: <%=ponuda.getDiskoteka()%>rsd
									</li>
									<li>Sportske igre: <%=ponuda.getSportskeIgre()%>rsd
									</li>
									<li>Igraonica: <%=ponuda.getIgraonica()%>rsd
									</li>
								</ul>
							</div>
							<div class="card-footer p-4 pt-0 bg-transparent border-top-0">
								<div class="d-flex align-items-end justify-content-between">
									<div class="d-flex align-items-center">
										
										<div class="small">
											<div class="fw-bold text-white-50"><%=agencija.getTelefon()%></div>
											<div class="text-muted"><%=agencija.getAdresa()%></div>
										</div>
									</div>
								</div>
								<p></p>
								<form method="get" action="Reservation" style="margin-left: 33%;">
									<input type="hidden" value="<%=agencija.getAgencijaID()%>"
										name="agencijaID"> 
									<input type="hidden" value="<%=agencija.getPonudaID()%>"
										name="ponudaID"> 
									<input type="submit"
										class="btn btn-primary" value="Rezervisi">
								</form>
							</div>
						</div>
					</div>
					<%} %>
				</div>

			</div>
		</section>
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
