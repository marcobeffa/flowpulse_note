class Content < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :slugged
  belongs_to :user
  before_save :set_publication_date

  before_validation :generate_unique_slug, on: :create




  # Enum per visibilità
  enum :visibility, { privato: 0, iscritti: 1, pubblico: 2 }

  # Enum per stato
  enum :stato, {
  ideazione: 0,              # La nota è un'idea iniziale
  catalogazione: 1,          # La nota è stata organizzata per argomento
  riordino: 2,               # La nota è stata strutturata in modo logico
  scrittura_storia: 3,       # La nota è sviluppata come testo narrativo o strutturato
  scrittura_discorso: 4,     # Adattamento per la comunicazione orale o video
  revisione: 5,              # La nota è stata rifinita con parole più precise
  finalizzata: 6,            # La nota è pronta per l'uso o la pubblicazione
  memorizzare: 7,            # Assimilazione attiva
  interpretare: 8,           # Personalizzazione e adattamento
  pratica: 9,                # Applicazione concreta nel mondo reale
  registrazione_video: 10,   # Registrazione o esposizione dal vivo
  editing: 11,               # Revisione avanzata ed editing finale
  titoli_descrizione: 12,    # Creazione di titoli e descrizioni per la pubblicazione
  pubblicazione: 13,         # Pubblicazione ufficiale del contenuto
  concluso: 14               # Il contenuto è chiuso e pubblicato
}

  # Validazioni
  validates :title, presence: true
  validates :body, presence: true
  validates :visibility, inclusion: { in: visibilities.keys }
  validates :stato, inclusion: { in: statos.keys }

  # Scopes utili
  scope :privato, -> { where(visibility: :privato) }
  scope :gruppo, -> { where(visibility: :gruppo) }
  scope :pubblico, -> { where(visibility: :pubblico) }
  scope :in_revisione, -> { where(stato: :revisione) }

# Scope per i contenuti con una data di pubblicazione futura, ordinati dal più vicino al più lontano
scope :published, -> { where("publication_date <= ?", Time.current).order(publication_date: :asc) }

# Scope per i contenuti pubblicati, ordinati dal più recente al più vecchio
scope :scheduled, -> { where("publication_date > ?", Time.current).order(publication_date: :desc) }


  # Metodo helper per verificare lo stato
  def bozza?
    stato == "bozza"
  end

  def pubblicato?
    stato == "pubblicato"
  end

  def revisione?
    stato == "revisione"
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "title", "body", "description" ]
  end


  def generate_unique_slug
    base_slug = title.parameterize
    slug_candidate = base_slug
    count = 1

    while Content.exists?(slug: slug_candidate, user_id: user_id)
      slug_candidate = "#{base_slug}-#{count}"
      count += 1
    end

    self.slug = slug_candidate
  end
  private

  def set_publication_date
    if self.published?
      if self.publication_date.nil? # || self.publication_date > Date.today  bug controller show
        self.publication_date = Time.current
      end
    end
    if !self.publication_date.nil?
      if publication_date <= Time.current
        update_column(:published, true) # Salva senza callback per evitare loop
      elsif publication_date > Time.current
        update_column(:published, false) # Salva senza callback per evitare loop
      end
    end
  end
end
