<!DOCTYPE html>
<html>

<head>

    <title>Resep App</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
<style>

:root{

    --primary:#673AB7;
    --primary-dark:#5E35B1;
    --primary-light:#EDE7F6;
    --background:#F5F0FF;
}

body{

    background:var(--background);

    font-family:'Segoe UI',sans-serif;
}

.navbar-custom{

    background:var(--primary);

    box-shadow:0 4px 15px rgba(103,58,183,.3);
}

.hero{

    background:linear-gradient(
        135deg,
        #673AB7,
        #7E57C2
    );

    color:white;

    padding:35px;

    border-radius:25px;

    margin-bottom:25px;

    box-shadow:0 8px 25px rgba(103,58,183,.3);
}

.hero .text-muted{

    color:#EDE7F6 !important;
}

.recipe-card{

    border:none;

    border-radius:20px;

    overflow:hidden;

    transition:.3s;

    background:white;

    box-shadow:0 5px 20px rgba(103,58,183,.12);
}

.recipe-card:hover{

    transform:translateY(-6px);

    box-shadow:0 12px 30px rgba(103,58,183,.25);
}

.btn-purple{

    background:#673AB7;

    color:white;

    border:none;

    border-radius:12px;
}

.btn-purple:hover{

    background:#5E35B1;

    color:white;
}

.page-title{

    font-weight:700;

    color:white;
}

.search-box{

    border:none;

    border-radius:15px;

    padding:15px;

    box-shadow:0 5px 15px rgba(103,58,183,.1);
}

.text-primary{
    color:#673AB7 !important;
}

.login-container{

    display:flex;

    min-height:85vh;

    overflow:hidden;

    border-radius:30px;

    background:white;

    box-shadow:0 10px 30px rgba(0,0,0,.1);
}

.login-left{

    flex:1;

    background-image:url('/images/login-food.jpg');

    background-size:cover;

    background-position:center;

    position:relative;
}

.overlay{

    position:absolute;

    inset:0;

    background:rgba(103,58,183,.65);

    color:white;

    display:flex;

    flex-direction:column;

    justify-content:center;

    align-items:center;

    text-align:center;

    padding:40px;
}

.overlay h1{

    font-size:48px;

    font-weight:bold;
}

.overlay p{

    font-size:18px;

    max-width:400px;
}

.login-right{

    flex:1;

    display:flex;

    justify-content:center;

    align-items:center;

    padding:40px;
}

.login-card{

    width:100%;

    max-width:450px;
}

.btn-login{

    background:#673AB7;

    color:white;

    padding:14px;

    border-radius:12px;

    border:none;
}

.btn-login:hover{

    background:#5E35B1;

    color:white;
}

.form-control{

    border-radius:12px;
}

@media(max-width:768px){

    .login-container{
        flex-direction:column;
    }

    .login-left{
        min-height:250px;
    }

}

/* Di luar media query */

.navbar-brand{
    color:#673AB7 !important;
    font-size:1.8rem;
    font-weight:700;
    letter-spacing:1px;
}

.navbar-brand:hover{
    color:#5E35B1 !important;
}

.nav-link{
    font-weight:500;
    margin-right:10px;
}

.nav-link:hover{
    color:#EDE7F6 !important;
}

.navbar-brand{
    color:#673AB7 !important;
    font-size:1.8rem;
    font-weight:700;
    letter-spacing:1px;
}

.navbar-brand:hover{
    color:#5E35B1 !important;
}

.nav-purple{
    color:#673AB7 !important;
    font-weight:600;
    padding:8px 16px !important;
    border-radius:10px;
    transition:.3s;
}

.nav-purple:hover{
    background:#EDE7F6;
    color:#5E35B1 !important;
}
}
</style>

</head>

<body>

<nav class="navbar navbar-expand-lg navbar-custom">

    <div class="container">

        <a
            class="navbar-brand fw-bold"
            href="/recipes">

            🍽 ResepKita

        </a>

        <button
            class="navbar-toggler bg-light"
            type="button"
            data-bs-toggle="collapse"
            data-bs-target="#navbarNav">

            <span class="navbar-toggler-icon"></span>

        </button>

<div class="ms-auto">

    @if(auth()->check())

    <div class="dropdown">

        <button
            class="btn btn-light dropdown-toggle"
            type="button"
            data-bs-toggle="dropdown">

            👤 {{ auth()->user()->name }}

        </button>

        <ul class="dropdown-menu dropdown-menu-end">

            <li>
                <a class="dropdown-item" href="/profile">
                    👤 Profil
                </a>
            </li>

            <li>
                <a class="dropdown-item" href="/favorites">
                    ❤️ Favorit
                </a>
            </li>

            <li>
                <hr class="dropdown-divider">
            </li>

            <li>
                <form action="/logout" method="POST">
                    @csrf

                    <button
                        type="submit"
                        class="dropdown-item text-danger">

                        Logout

                    </button>

                </form>
            </li>

        </ul>

    </div>

    @endif

</div>

        </div>

    </div>

</nav>

<div class="container mt-5">

    @yield('content')

</div>

</body>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</html>