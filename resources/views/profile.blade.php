@extends('layouts.app')

@section('content')

<div class="row justify-content-center">

    <div class="col-md-6">

        <div class="card shadow border-0">

            <div class="card-body text-center">

                <div
                    class="rounded-circle mx-auto mb-3 d-flex align-items-center justify-content-center"
                    style="
                        width:120px;
                        height:120px;
                        background:#673AB7;
                        color:white;
                        font-size:50px;
                    ">

                    {{ strtoupper(substr(auth()->user()->name,0,1)) }}

                </div>

                <h3>

                    {{ auth()->user()->name }}

                </h3>

                <p class="text-muted">

                    {{ auth()->user()->email }}

                </p>

                <hr>

                <form
                    action="/logout"
                    method="POST">

                    @csrf

                    <button
                        class="btn btn-danger">

                        Logout

                    </button>

                </form>

            </div>

        </div>

    </div>

</div>

<div class="alert alert-light mt-3">

    Total Resep Dibuat

    <h3 class="text-primary">

        {{ $recipeCount }}

    </h3>

</div>

@endsection