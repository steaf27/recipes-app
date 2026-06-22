@extends('layouts.app')

@section('content')

<div class="login-container">

    <div class="login-left">

        <div class="overlay">

            <h1>🍽 Resepku</h1>

            <p>
                Temukan dan simpan resep favoritmu
                dalam satu tempat.
            </p>

        </div>

    </div>

    <div class="login-right">

        <div class="login-card">

            <h2>Selamat Datang 👋</h2>

            <p class="text-muted mb-4">
                Login untuk melanjutkan
            </p>

            @if(session('error'))

                <div class="alert alert-danger">

                    {{ session('error') }}

                </div>

            @endif

            <form action="/login" method="POST">

                @csrf

                <div class="mb-3">

                    <input
                        type="email"
                        name="email"
                        class="form-control form-control-lg"
                        placeholder="Email">

                </div>

                <div class="mb-4">

                    <input
                        type="password"
                        name="password"
                        class="form-control form-control-lg"
                        placeholder="Password">

                </div>

                <button
                    class="btn btn-login w-100">

                    LOGIN

                </button>

            </form>

            <div class="text-center mt-4">

                Belum punya akun?

                <a href="/register">

                    Daftar disini

                </a>

            </div>

        </div>

    </div>

</div>

@endsection