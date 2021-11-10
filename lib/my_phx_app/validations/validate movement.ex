defmodule MyPhxApp.Validations.ValidateMovement do
  use Ecto.Schema
  import Ecto.Changeset

  schema "movement" do
    field :movimentos, Ecto.JSON
  end

  @derive {Poison.Encoder, only: [:movimentos]}
  @required_params [:movimentos]

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:movimentos, min: 1)
    |> validList(params["movimentos"])
    |> response()
  end

  def validList(changeset, params) do
    cond do
      Enum.count(params) == 0  -> changeset
      Enum.member?(["M", "GE", "GD"],  String.upcase(List.first(params))) == false  ->
        add_error(changeset, :movimentos, "Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #{List.first(params)}")
      Enum.member?(["M", "GE", "GD"],  String.upcase(List.first(params))) == true  ->
         List.delete(params,  List.first(params))
         |> (&(validList(changeset, &1))).()
    end
  end

  def response(changeset) do
    case changeset.valid? do
      true -> {:ok ,changeset.changes[:movimentos]}
      false -> {:error, changeset.errors[:movimentos]}

    end
  end

end
