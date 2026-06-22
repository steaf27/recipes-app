@extends('layouts.app')

@section('content')

@if(session('success'))

<div
    class="alert alert-success shadow-sm border-0 alert-dismissible fade show"
    style="
        background:#EDE7F6;
        color:#673AB7;
        border-radius:15px;
    ">

    {{ session('success') }}

    <button
        type="button"
        class="btn-close"
        data-bs-dismiss="alert">
    </button>

</div>

@endif

@php

$isFavorite =
    \App\Models\Favorite::where(
        'user_id',
        auth()->id()
    )
    ->where(
        'recipe_id',
        $recipe->id
    )
    ->exists();

@endphp

<div class="row justify-content-center">

    <div class="col-lg-8">

        <div class="card recipe-card">

            @if($recipe->image)

            <img
                src="{{ asset('storage/'.$recipe->image) }}"
                class="card-img-top"
                style="
                    height:400px;
                    object-fit:cover;
                ">

            @endif

            <div class="card-body p-4">

                <div class="d-flex justify-content-between align-items-center">

                    <h1 class="fw-bold text-primary mb-0">

                        🍽 {{ $recipe->title }}

                    </h1>

                    <form
                        action="/favorites/{{ $recipe->id }}"
                        method="POST">

                        @csrf

                        <button
                            type="submit"
                            class="btn btn-danger">

                            {{ $isFavorite ? '❤️ Hapus Favorit' : '🤍 Simpan Favorit' }}

                        </button>

                    </form>

                </div>

                <hr>

                <h5>Deskripsi</h5>

                <p class="text-muted">

                    {{ $recipe->description }}

                </p>

                <h4>Bahan-bahan</h4>

                <pre>{{ $recipe->ingredients }}</pre>

                <hr>

                <h4>Alat</h4>

                <pre>{{ $recipe->tools }}</pre>

                <hr>

                <h4>Langkah-langkah</h4>

                <pre>{{ $recipe->steps }}</pre>

                <a
                    href="/recipes"
                    class="btn btn-secondary">

                    ← Kembali

                </a>

                <hr>

<h3 class="mb-4">

    💬 Komentar
    ({{ $recipe->comments->count() }})

</h3>

<form
    action="/recipes/{{ $recipe->id }}/comment"
    method="POST">

    @csrf

    <textarea
        name="comment"
        class="form-control mb-3"
        rows="3"
        placeholder="Tulis komentar..."></textarea>

    <button
        type="submit"
        class="btn btn-purple">

        Kirim Komentar

    </button>

</form>

<hr>

@forelse($recipe->comments->sortByDesc('created_at') as $comment)

<div class="card mb-3 border-0 shadow-sm">

    <div class="card-body">

        <div class="d-flex justify-content-between align-items-start">

            <div>

                <h6 class="fw-bold">

                    👤 {{ $comment->user->name }}

                </h6>

                <p class="mb-1">

                    {{ $comment->comment }}

                </p>

                <small class="text-muted">

                    {{ $comment->created_at->diffForHumans() }}

                </small>

            </div>

            @if(auth()->id() == $comment->user_id)

            <form
                action="/comments/{{ $comment->id }}"
                method="POST">

                @csrf
                @method('DELETE')

                <button
                    type="submit"
                    onclick="return confirm('Hapus komentar ini?')"
                    class="btn btn-sm btn-danger">

                    🗑 Hapus

                </button>

            </form>

            @endif

        </div>

    </div>

</div>

@empty

<div class="alert alert-info">

    Belum ada komentar.

</div>

@endforelse

            </div>

        </div>

    </div>

</div>

@endsection