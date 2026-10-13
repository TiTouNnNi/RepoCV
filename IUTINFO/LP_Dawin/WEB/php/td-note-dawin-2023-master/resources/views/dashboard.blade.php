<div class="container">
    <h1>Today</h1>
    @foreach($buildings as $building)
        <h2>{{ $building->name }}</h2>
        <ul>
            @foreach($building->reservations as $reservation)
                <li>{{ $reservation->user->name }}</li>
            @endforeach
        </ul>
    @endforeach
</div>