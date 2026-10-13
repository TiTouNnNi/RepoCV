<form method="post" action="{{ route('reserve') }}">
    @csrf
    <div class="form-group">
        <label for="building">Building:</label>
        <select id="building" name="building" class="form-control">
            @foreach($buildings as $building)
                <option value="{{ $building->name }}">{{ $building->name }}</option>
            @endforeach
        </select>
    </div>
    <div class="form-group">
        <label for="date">Date:</label>
        <input id="date" type="date" name="date" class="form-control">
    </div>
    <button type="submit" class="btn btn-primary">Reserve</button>
</form>