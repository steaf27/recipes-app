@extends('layouts.app')

@section('content')

<div class="card recipe-card">

    <div class="card-body p-4">

        <h2 class="page-title mb-4">

            Edit Resep

        </h2>

        <form
            action="/recipes/{{ $recipe->id }}"
            method="POST"
            enctype="multipart/form-data">

            @csrf
            @method('PUT')

            <div class="mb-3">

                <label>Judul Resep</label>

                <input
                    type="text"
                    name="title"
                    value="{{ $recipe->title }}"
                    class="form-control">

            </div>

            <div class="mb-3">

                <label>Deskripsi</label>

                <textarea
                    name="description"
                    rows="4"
                    class="form-control">{{ $recipe->description }}</textarea>
                <div class="mb-3">

    <label>Bahan-bahan</label>

    <textarea
        name="ingredients"
        rows="6"
        class="form-control auto-number">{{ $recipe->ingredients }}</textarea>

</div>

<div class="mb-3">

    <label>Alat</label>

    <textarea
        name="tools"
        rows="6"
        class="form-control auto-number">{{ $recipe->tools }}</textarea>

</div>

<div class="mb-3">

    <label>Langkah-langkah</label>

    <textarea
        name="steps"
        rows="8"
        class="form-control auto-number">{{ $recipe->steps }}</textarea>

</div> 
            </div>

            @if($recipe->image)

            <div class="mb-3">

                <img
    id="preview"
    src="{{ $recipe->image ? asset('storage/'.$recipe->image) : '' }}"
    style="
        width:100%;
        max-height:250px;
        object-fit:cover;
        border-radius:15px;
        {{ $recipe->image ? '' : 'display:none;' }}
    ">

            </div>

            @endif

           <div class="mb-3">

    <label>Ganti Foto</label>

    <input
        type="file"
        name="image"
        class="form-control"
        onchange="previewImage(event)">

</div>

            <button
                type="submit"
                class="btn btn-purple">

                Update Resep

            </button>

        </form>

    </div>

</div>

@endsection

<script>

document
.querySelectorAll('.auto-number')
.forEach(textarea => {

    textarea.addEventListener(
        'keydown',
        function(e){

            if(e.key === 'Enter'){

                e.preventDefault();

                let lines =
                    this.value
                    .split('\n')
                    .filter(
                        line => line.trim() !== ''
                    );

                let next =
                    lines.length + 1;

                this.value +=
                    '\n' + next + '. ';
            }
        }
    );

});

</script>