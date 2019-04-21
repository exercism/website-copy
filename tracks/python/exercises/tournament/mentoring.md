### Problem and challenges

You are given the results of a series of games, and
asked to print the results for the season.

You need to parse alternative ways to describe a game,
keep track of data, and print the data in a fixed form.
The data must be sorted by points and team names.

### Reasonable solutions

```python
import collections 

def defaultValue():
    return [0, 0, 0]

def points(standings: dict, team: str) -> int:
    return 3*standings[team][0] + standings[team][1]

def tally(results):
    table = ['Team                           | MP |  W |  D |  L |  P']
    if len(results) == 0:
        return table[0]

    scores = collections.defaultdict(defaultValue)
    acts = {'win': [1, 0, 0], 'loss': [0, 0, 1], 'draw': [0, 1, 0]}

    for line in results.split('\n'):
        team1, team2, action = tuple(line.split(';'))
        scores[team1] = [scores[team1][i] + acts[action][i] for i in range(3)]
        scores[team2] = [scores[team2][i] + acts[action][::-1][i] for i in range(3)]

    # Need to sort by score, and then by name
    # Negate scores so that largest appear first
    lst = sorted([(-points(scores, team), team) for team in scores])

    format_str = '%-30s | %2d | %2d | %2d | %2d | %2d'
    for _, team in lst:
        l = scores[team]
        # games, won, draw, lost, points
        g, w, d, l, p = (l[0] + l[1] + l[2], l[0], l[1], l[2], 3*l[0] + l[1])
        s = format_str % (team, g, w, d, l, p)
        table.append(s)

    return '\n'.join(table)
```

#### Storage

For each game, we need to store results for both teams by name.
A dictionary is a natural place, with the team name as the key
and a list with the number of wins, losses and draws.
We could also store the points, or compute those at the end.

A default Dictionary would simplify the updates.
However, we can't depend on a stock defaultdict(list),
as we need a list of zeros as the default value.

We define a defaultValue() function above to take care of this.

#### Handling Scores

Each line contains the information about one game:
won, lost, or drawn.

```python
    'Allegoric Alaskans;Blithering Badgers;win'
```

The same game could also be described as 

```python
    'Blithering Badgers;Allegoric Alaskans;loss'
```

We need to split the line, decide who won, 
and update the stats for both teams.

#### Reporting the result

The results need to be sorted by points and name.
The points are computed based on the number of wins and draws.
Two teams with the same number of points are listed in 
alphabetic order.

The listings are printed in a fixed width format.

One way to produce a sorted list of the team names would
be to create a list of pairs holding the name and the points.

```python
    lst = [(team, points(team)) for team in standings]
    lst = sorted(lst, key=itemgetter(0))
    lst = sorted(lst, key=itemgetter(1), reverse=True)
```

We then sort by names, followed by sorting by value.
Python's sorts are stable: that is, two teams with
the same points will remain in the same relative order.

Another approach would be to build a list of tuples,
and use the natural odering for tuples to simplify the sort.
However, we want the teams in descending order of points,
and then in ascending order by name.
We handle that below by negating the points.

```python
    lst = [(-points(team), team) for team in standings]
    def by_points_and_name(self):
        return (-self.points(), self.name)
```

The third way to sort would be to pass in a function.
There are two types of functions: one takes a single team
and maps it to a key which can be compared,
while the second method uses a comparator function which
takes two teams and compares them.
It is preferable to use the first method: the function
only needs to be called once per team.
