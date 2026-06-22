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

            <h2>Buat Akun Baru 🚀</h2>

            <p class="text-muted mb-4">
                Buat akun baru untuk melanjutkan
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

                    REGISTER

                </button>

            </form>

            <div class="text-center mt-4">

                Sudah punya akun ?

                <a href="/login">

                    Login disini

                </a>

            </div>

        </div>

    </div>

</div>

@endsection