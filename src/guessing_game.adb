with Ada.Text_IO;
with Ada.Numerics.Discrete_Random;

procedure Guessing_Game is
   subtype Small_Number is Integer range 1 .. 100;

   package Random_Secret is new Ada.Numerics.Discrete_Random (Small_Number);
   use Ada.Text_IO;

   Seed : Random_Secret.Generator;
   Secret_Number : Small_Number;
begin
   Random_Secret.Reset (Seed);
   Secret_Number := Random_Secret.Random (Seed);

   Put_Line ("Guess the number");

   Game : loop
      Put_Line ("Please input your guess.");

      begin
         declare
            Input : constant String := Get_Line;
            Guess : constant Small_Number := Small_Number'Value (Input);
         begin
            Put_Line ("You guessed: " & Small_Number'Image (Guess));

            if Guess < Secret_Number then
               Put_Line ("Your guess was too low!");
            elsif Guess > Secret_Number then
               Put_Line ("Your guess was too high!");
            else
               Put_Line ("Wow, you guessed right!");
               exit Game;
            end if;
         end;
      exception
         when Constraint_Error =>
            null;
      end;
   end loop Game;

   Put_Line ("The secret number was: " & Small_Number'Image (Secret_Number));
end Guessing_Game;
