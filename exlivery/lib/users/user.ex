defmodule Exlivery.Users.User do
  @keys [:name, :email, :cpf, :age]
  @enforce_keys @keys

  defstruct @keys

  def build(age, cpf, email, name) when age >= 18 do
    {:ok,
     %__MODULE__{
       age: age,
       cpf: cpf,
       email: email,
       name: name
     }}
  end

  def build(age, _cpf, _email, _name) when age <= 18 do
    {:error, "Must be over 18"}
  end
end
