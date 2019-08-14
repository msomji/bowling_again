# Bowling Kata

Everyone solves problems in different ways. Over the years I have learned different strategies to break down seemingly complex problems to relatively simple ones using a few very basic concepts that will be demonstrated below.

## Process: 
 1. Pseudo code. All of it! (This may seem like a recomendation for a Jr. Dev, but truely do it, even if you're a 10X Dev - you need it even more.)
 2. write code.
 3. Fin.

Instead of writing out sentences of what I want, I rely on the specific contract I am trying to implement. Below there are a list of high level objectives identified via the following structure that will be reffered to as the contract:
  
  ``` input ------<method name> ------> output ```
  
Once these higher level objectives are defined, each is broken down into a group of additional contracts that will be needed to get from what was provided (`input`) to the expected result(`output`).

This Kata was written while keeping the boundaries of each of the methods in mind. By writing out all the nessesary contracts/methods for the kata before hand it is very easy to reason about the code and identify any missing pieces well in advance. 

Objectives:
1. `[name] ------------- initialize---------> [Players]` 
2. `[name, [pins, pins]] ----add_frame---------> [[pins, pins], [],[],[],[],[],[],[],[],[],[]]` 
3. `name? ----get_score-----> ScoreBoard` 
    ```
    ScoreBoard = [
        {
            name: name,
            player_board: []
        }
    ]
    ```
---
## add_frame:
` [name, [pins, pins]]   ----add_frame-------->   [[pins, pins], [],[],[],[],[],[],[],[],[],[]]`

    name                 ---getplayer_board---->   player_board ([[], [],[],[],[],[],[],[],[],[],[]])
    [pins, pins, ?pins]  ---validate----------->   bool
    name ,[pins, pins]   ----submit_frame------->   [[pins, pins], [],[],[],[],[],[],[],[],[],[]]

---
## getScoreBoard:
`  player_board ---------getScoreBoard-----> [scoreBoard]` 

    frame                        ---is_strike------------->   bool
    frame                        ---is_spare-------------->   bool
    frame                        ---sum_frame------------>   simpleFrameSum
    frame, nextRoll              ---sum_spare_frame-------->   simpleFrameSum
    frame, nextFrame, thirdframe ---sum_strike_frame------->   simpleFrameSum
    [simpleFrameSum]             ---cumulative_frame_sums-->   cumulativeFrameSums

---
## validate
`   [pins, pins, ?pins], current_frame_number ----validate------>   bool`
   
    CurrentFrameNumber       -----is_less_than_ten----------------->   bool
    frame                    -----validate_non_last_frame------>   bool
    frame                    -----validate_non_last_frame------>   bool
