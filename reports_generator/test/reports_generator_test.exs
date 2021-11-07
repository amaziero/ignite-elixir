defmodule ReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "builds the report" do
      file_name = "report_test.csv"

      response = ReportsGenerator.build(file_name)

      expected_response = %{
        "foods" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pastel" => 0,
          "pizza" => 2,
          "prato_feito" => 0,
          "sushi" => 0
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 45,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 31,
          "30" => 0,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert response == expected_response
    end
  end

  describe "fecth_higher_cost/2" do
    test "when the option is 'users', returns the user who spent the most" do
      file_name = "report_test.csv"
      option = "users"

      response =
        file_name |> ReportsGenerator.build() |> ReportsGenerator.fetch_higher_cost(option)

      expected_response = {:ok, {"5", 49}}

      assert response == expected_response
    end

    test "when the option is 'food', returns the food which is bought the most" do
      file_name = "report_test.csv"
      option = "foods"

      response =
        file_name |> ReportsGenerator.build() |> ReportsGenerator.fetch_higher_cost(option)

      expected_response = {:ok, {"esfirra", 3}}

      assert response == expected_response
    end

    test "when the option is not valid, throws an error" do
      file_name = "report_test.csv"
      option = "not_valid"

      response =
        file_name |> ReportsGenerator.build() |> ReportsGenerator.fetch_higher_cost(option)

      expected_response = {:error, "Invalid Option"}

      assert response == expected_response
    end
  end

  describe "build_from_many/1" do
    test "when a file list is provided, builds the report" do
      filenames = ["report_1.csv", "report_3.csv", "report_3.csv"]

      response = ReportsGenerator.build_from_many(filenames)

      expected_response =
        {:ok,
         %{
           "foods" => %{
             "açaí" => 37551,
             "churrasco" => 37779,
             "esfirra" => 37684,
             "hambúrguer" => 37521,
             "pastel" => 37269,
             "pizza" => 37380,
             "prato_feito" => 37610,
             "sushi" => 37206
           },
           "users" => %{
             "1" => 283_167,
             "10" => 272_251,
             "11" => 269_457,
             "12" => 273_721,
             "13" => 284_812,
             "14" => 274_625,
             "15" => 282_370,
             "16" => 270_170,
             "17" => 276_073,
             "18" => 268_047,
             "19" => 278_030,
             "2" => 270_787,
             "20" => 273_817,
             "21" => 275_959,
             "22" => 278_603,
             "23" => 279_724,
             "24" => 275_413,
             "25" => 269_977,
             "26" => 275_562,
             "27" => 278_753,
             "28" => 275_074,
             "29" => 270_559,
             "3" => 271_857,
             "30" => 274_040,
             "4" => 274_878,
             "5" => 267_749,
             "6" => 270_205,
             "7" => 273_022,
             "8" => 277_922,
             "9" => 273_152
           }
         }}

      assert response == expected_response
    end

    test "when no file list is provided, throws an error" do
      filenames = "not_a_list"

      response = ReportsGenerator.build_from_many(filenames)

      expected_response = {:error, "Fail loading list"}

      assert response == expected_response
    end
  end
end
