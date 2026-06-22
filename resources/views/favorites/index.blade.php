@extends('layouts.app')

@section('content')

<div class="hero">

    <h2 class="page-title">

        ❤️ Resep Favorit

    </h2>

</div>

<div class="row">

@foreach($favorites as $favorite)

<div class="col-md-4 mb-4">

    <div class="card recipe-card">

        @if($favorite->recipe->image)

        <img
            src="{{ asset('storage/'.$favorite->recipe->image) }}"
            class="card-img-top"
            style="height:220px;object-fit:cover;">

        @endif

        <div class="card-body">

            <h5>

                {{ $favorite->recipe->title }}

            </h5>

            <a
                href="/recipes/{{ $favorite->recipe->id }}"
                class="btn btn-purple">

                Lihat Resep

            </a>

        </div>

    </div>

</div>

@endforeach

</div>

@endsection