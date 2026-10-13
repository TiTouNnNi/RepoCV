<div class="container">
    <h1>Reservations</h1>
    <table>
        <thead>
            <tr>
                <th>Building</th>
                <th>Date</th>
                <th>User</th>
            </tr>
        </thead>
        <tbody>
            @foreach($reservations as $reservation)
                <tr>
                    <td>{{ $reservation->building }}</td>
                    <td>{{ $reservation->date }}</td>
                    <td>{{ $reservation->user->name }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
</div>